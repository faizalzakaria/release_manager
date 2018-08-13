# frozen_string_literal: true

module ReleaseManager
  module Client
    #
    # Slack Client
    #
    class Slack
      class << self
        include AuthOptionBuilder

        def build_auth_options_by_tty
          puts 'Configuring Slack ...'

          prompt = TTY::Prompt.new

          result = prompt.collect do
            key(:webhook_url).ask('[SLACK] Webhook url (ex: https://hooks.slack.com/services/T09NLCN11/B6M3ZM6QG/WEWQ831)', required: true)
            key(:channel).ask('[SLACK] Channel: (default: #news)', default: '#news')
          end

          result
        end

        def webhook_url
          build_auth_options[:webhook_url]
        end

        def channel
          build_auth_options[:channel]
        end

        private

        def auth_cache_key
          'auth-slack'
        end
      end
    end
  end
end
