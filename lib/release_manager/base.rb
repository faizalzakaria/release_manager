$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'release'
require 'notifier'

module ReleaseManager
  class Base
    def initialize(options)
      @access_token      = options[:access_token]
      @pr_number         = options[:pr_number]
      @tag_name          = options[:tag_name]
      @repo              = options[:repo]
      @slack_webhook_url = options[:slack_webhook_url]
      @release_manager   = options[:release_manager]
      @channel           = options[:channel]
    end

    def release
      if (release = create_release)
        notify(release)
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
        slack_webhook_url: @slack_webhook_url,
        release_manager: @release_manager,
        channel: @channel
      ).notify
    end
  end
end
