# frozen_string_literal: true

module ReleaseManager
  class Slack
    attr_reader :webhook_url, :channel

    def initialize
      @webhook_url = build_auth_options[:webhook_url]
      @channel     = build_auth_options[:channel] || '#news'
    end

    def notify(text, user, opts = {})
      encoded_params = "payload=#{build_payload(text, user)}"
      if opts[:dry_run]
        puts "curl -X POST --data-urlencode '#{encoded_params}' #{@webhook_url}"
      else
        `curl -X POST --data-urlencode '#{encoded_params}' #{@webhook_url}`
      end
    end

    private

    def build_payload(text, user)
      {
        channel: channel,
        username: user,
        text: text
      }.to_json.to_s
    end

    def build_auth_options
      ReleaseManager::AuthOptionBuilder::Slack.build_auth_options
    end
  end
end
