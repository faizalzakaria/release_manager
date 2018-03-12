$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'release'
require 'notifier'

module ReleaseManager
  class Base
    def initialize(options)
      @access_token      = options[:access_token]
      @pr_number         = options[:pr_number]
      @tag_name          = options[:tag_name]
      @release_manager   = options[:release_manager]
      @repo              = options[:repo]
      @notifier_configs  = options[:notifiers]
    end

    def release
      if (release = create_release)
        notify(release)
      else
        puts 'Failed to create a release!'
      end
    end

    private

    def create_release
      Release.new(
        access_token: @access_token,
        pr_number: @pr_number,
        tag_name: @tag_name,
        repo: @repo
      ).create
    end

    def notify(release)
      Notifier.new(
        tag_name: release.tag_name,
        repo: release.repo || @repo,
        release_manager: @release_manager,
        options: @notifier_configs
      ).notify
    end
  end
end
