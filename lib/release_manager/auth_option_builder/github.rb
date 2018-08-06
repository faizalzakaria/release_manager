# frozen_string_literal: true

#
# Github
#
module ReleaseManager
  module AuthOptionBuilder
    class Github < Base
      class << self
        def build_auth_options_by_tty(_options = {})
          prompt = TTY::Prompt.new

          result = prompt.collect do
            key(:repo).ask('[GITHUB] Repo (ex: faizalzakaria/test_release):', required: true)
            key(:access_token).mask('[GITHUB] Access token (https://github.com/settings/tokens)', required: true)
          end

          result
        end

        def auth_cache_key
          'auth-github'
        end
      end
    end
  end
end
