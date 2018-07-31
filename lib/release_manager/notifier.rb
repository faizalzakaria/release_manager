# coding: utf-8
# frozen_string_literal: true

require 'json'
$notifiers_dir = File.expand_path(File.join(File.dirname(__FILE__), 'notifiers'))
Dir.glob("#{$notifiers_dir}/*.rb").each { |f| require_relative File.join('notifiers', File.basename(f)) }

module ReleaseManager
  class Notifier
    NOTIFIERS = Dir.glob("#{$notifiers_dir}/*.rb").map { |f| File.basename(f, '.rb') }

    def initialize(repo:, tag_name:, user:)
      @repo     = repo
      @tag_name = tag_name
      @user     = user
    end

    def notify
      NOTIFIERS.each do |notifier|
        klazz = ReleaseManager.const_get(camelize(notifier))
        klazz.new.notify(default_template, user: @user)
      end
    end

    private

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
      Time.now.strftime('%b %d')
    end

    def default_template
      <<~END
        :tada: *#{@tag_name}* · _#{date_today}_
        > More info can be found here,
        > *Changelog*: #{release_url}
      END
    end

    def camelize(string, uppercase_first_letter = true)
      string = if uppercase_first_letter
                 string.sub(/^[a-z\d]*/) { $&.capitalize }
               else
                 string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
               end
      string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}" }.gsub('/', '::')
    end
  end
end
