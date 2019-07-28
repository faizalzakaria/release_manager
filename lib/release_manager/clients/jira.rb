# frozen_string_literal: true

module ReleaseManager
  module Client
    #
    # Jira Client
    #
    class Jira
      class << self
        include AuthOptionBuilder

        def build_auth_options_by_tty
          puts 'Configuring Jira ...'
          prompt = TTY::Prompt.new

          result = prompt.collect do
            key(:site).ask('[JIRA] Site (ex: https://myjira.atlassian.net):', required: true)
            key(:context_path).ask('[JIRA] Jira path in your site (just press enter if you don\'t have):', default: '')
            key(:username).ask('[JIRA] Username:', required: true)
            key(:password).mask('[JIRA] Auth token: (create 1 here, https://id.atlassian.com/manage/api-tokens)', required: true)
            key(:project).ask('[JIRA] Project (ex: OA)', required: true)
          end

          result[:auth_type] = :basic
          result[:use_ssl] ||= false if result[:site] =~ %r{http://}
          result[:http_debug] = true

          result
        end

        def client
          @client ||= JIRA::Client.new(build_auth_options)
        end

        def project
          build_auth_options[:project]
        end

        def site
          build_auth_options[:site]
        end

        private

        def auth_cache_key
          'auth-jira'
        end
      end
    end
  end
end
