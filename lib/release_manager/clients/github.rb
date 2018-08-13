# frozen_string_literal: true

module ReleaseManager
  module Client
    #
    # Github Client
    #
    class Github
      class << self
        include AuthOptionBuilder

        def build_auth_options_by_tty
          puts 'Configuring github ...'
          prompt = TTY::Prompt.new

          result = prompt.collect do
            key(:repo).ask('[GITHUB] Repo (ex: faizalzakaria/test_release):', required: true)
            key(:access_token).mask('[GITHUB] Access token (https://github.com/settings/tokens)', required: true)
          end

          result
        end

        def client
          @client ||= ::Octokit::Client.new(access_token: access_token)
        end

        def access_token
          build_auth_options[:access_token]
        end

        def repo
          build_auth_options[:repo]
        end

        private

        def auth_cache_key
          'auth-github'
        end
      end
    end
  end
end
