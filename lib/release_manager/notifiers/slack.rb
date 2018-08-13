# frozen_string_literal: true

module ReleaseManager
  module Notifier
    #
    # Slack notifier
    #
    class Slack < Base
      class << self
        def notify(text, user:, dry_run: false)
          encoded_params = "payload=#{build_payload(text, user)}"
          if dry_run
            puts "curl -X POST --data-urlencode '#{encoded_params}' #{webhook_url}"
          else
            `curl -X POST --data-urlencode '#{encoded_params}' #{webhook_url}`
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

        def webhook_url
          ReleaseManager::Client::Slack.webhook_url
        end

        def channel
          ReleaseManager::Client::Slack.channel
        end
      end
    end
  end
end
