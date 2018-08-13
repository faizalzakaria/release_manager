# frozen_string_literal: true

module ReleaseManager
  #
  # Cli
  #
  class Cli < Thor
    desc 'init', 'Init configs'
    long_desc <<-LONGDESC
      Init the configs
    LONGDESC
    def init
      ReleaseManager::Client::Github.build_auth_options
      ReleaseManager::Client::Jira.build_auth_options
      ReleaseManager::Client::Slack.build_auth_options

      puts 'DONE!'
    end

    desc 'reset', 'Reset configs'
    long_desc <<-LONGDESC
      Reset all the configs
    LONGDESC
    def reset
      ReleaseManager::Client::Github.expire_auth_options
      ReleaseManager::Client::Jira.expire_auth_options
      ReleaseManager::Client::Slack.expire_auth_options

      puts 'DONE!'
    end

    desc 'announce', 'announce a release'
    long_desc <<-LONGDESC
      This will create a Tag, with tag title as the PR title.
      and tag body as per the PR body.
    LONGDESC
    def announce
      AnnounceService.run
    end

    desc 'prepare', 'prepare a release ()'
    long_desc <<-LONGDESC
      This will create a Pull Request in Github
      with sprint report as PR body
    LONGDESC
    def prepare
      PrepareService.run
    end
  end
end
