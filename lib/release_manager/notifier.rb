# coding: utf-8
require 'json'
Dir.glob('lib/release_manager/notifiers/*.rb').each { |f| require_relative File.join('notifiers', File.basename(f)) }

module ReleaseManager
  class Notifier

    NOTIFIERS = Dir.glob('lib/release_manager/notifiers/*.rb').map { |f| File.basename(f, '.rb') }

    def initialize(repo:, tag_name:, release_manager:, options:)
      @repo              = repo
      @tag_name          = tag_name
      @release_manager   = release_manager
      @options           = options
    end

    def notify
      NOTIFIERS.each do |notifier|
        next unless (config = @options[notifier.to_sym])
        next unless config[:enabled]

        klazz = ReleaseManager.const_get(camelize(notifier))
        klazz.new(config).notify(default_template, release_manager: release_manager)
      end
    end

    private

    def release_manager
      @release_manager || 'fai'
    end

    def github_url
      'https://github.com/'
    end

    def release_url
      github_url + @repo + '/releases/tag/' + @tag_name
    end

    def template
      default_template
    end

    def date_today
      Time.now.strftime("%b %d")
    end

    def default_template
      <<~END
      :tada: *#{@tag_name}* · _#{date_today}_
      > More info can be found here,
      > *Changelog*: #{release_url}
      END
    end

    def camelize(string, uppercase_first_letter = true)
      if uppercase_first_letter
        string = string.sub(/^[a-z\d]*/) { $&.capitalize }
      else
        string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
      end
      string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub('/', '::')
    end
  end
end
