# coding: utf-8
require 'json'

module ReleaseManager
  class Notifier
    attr_reader :repo, :tag_name, :slack_webhook_url

    def initialize(repo:, tag_name:, slack_webhook_url:, release_manager:)
      @repo              = repo
      @tag_name          = tag_name
      @slack_webhook_url = slack_webhook_url
      @release_manager   = release_manager
    end

    def notify
      `curl -X POST --data-urlencode 'payload=#{payload}' #{slack_webhook_url}`
    end

    def release_manager
      @user || 'fai'
    end

    private

    def payload
      {
        channel: '#hearttop',
        username: release_manager,
        text: default_template
      }.to_json.to_s
    end

    def github_url
      'https://github.com/'
    end

    def release_url
      github_url + repo + '/releases/tag/' + @tag_name
    end

    def template
      default_template
    end

    def date_today
      Time.now.strftime("%b %d")
    end

    def default_template
      <<~END
      :tada: *#{tag_name}* · _#{date_today}_
      > More info can be found here,
      > *Changelog*: #{release_url}
      END
    end
  end
end
