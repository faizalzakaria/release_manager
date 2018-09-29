# frozen_string_literal: true

module ReleaseManager
  #
  # Subcommand for Reset
  #
  class ResetCli < Thor
    namespace "reset"

    desc 'all', 'reset all configs'
    def all
      ReleaseManager::Client::Github.expire_auth_options
      ReleaseManager::Client::Jira.expire_auth_options
      ReleaseManager::Client::Slack.expire_auth_options
      puts 'DONE!'
    end

    desc 'slack', 'reset slack configs'
    def slack
      ReleaseManager::Client::Slack.expire_auth_options
      puts 'DONE!'
    end

    desc 'github', 'reset slack configs'
    def github
      ReleaseManager::Client::Github.expire_auth_options
      puts 'DONE!'
    end

    desc 'jira', 'reset slack configs'
    def jira
      ReleaseManager::Client::Jira.expire_auth_options
      puts 'DONE!'
    end
  end
end
