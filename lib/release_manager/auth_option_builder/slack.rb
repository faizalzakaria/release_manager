#
# Slack
#
module ReleaseManager
  module AuthOptionBuilder
    class Slack < Base
      class << self
        def build_auth_options_by_tty(options = {})
          prompt = TTY::Prompt.new

          result = prompt.collect do
            key(:webhook_url).ask('[SLACK] Webhook url (ex: https://hooks.slack.com/services/T09NLCN11/B6M3ZM6QG/WEWQ831)', required: true)
            key(:channel).ask('[SLACK] Channel: (default: #news)', default: "#news")
          end

          result
        end

        def auth_cache_key
          'auth-slack'
        end
      end
    end
  end
end
