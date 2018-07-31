# frozen_string_literal: true

require 'octokit'

module ReleaseManager
  class Release
    attr_reader :access_token, :pr, :repo

    def initialize(options = {})
      @access_token = build_auth_options[:access_token]
      @repo         = build_auth_options[:repo]

      @pr           = options[:pr]
    end

    # Create Pull Request
    def prepare(title, notes)
      if pr
        github_client.update_pull_request(repo, pr, title: title, body: notes)
      else
        github_client.create_pull_request(repo, 'master', 'develop', title, notes)
      end
    end

    # Create Tag
    def create
      unless pull_merged?
        puts 'Pull Request is not merged yet'
        return
      end
      create_release
    end

    def tag_name
      @tag_name ||= pull_request.title
    end

    private

    def github_client
      @github_client ||= Octokit::Client.new(access_token: access_token)
    end

    def pull_merged?
      github_client.pull_merged?(repo, pr)
    end

    def pull_request
      github_client.close_pull_request(repo, pr)
    end

    def merge_commit_sha
      pull_request.merge_commit_sha
    end

    def release_notes
      pull_request.body
    end

    def create_release
      github_client.create_release(repo, tag_name, body: release_notes, name: tag_name, draft: false, target_commitish: merge_commit_sha)
    end

    def build_auth_options
      ReleaseManager::AuthOptionBuilder::Github.build_auth_options
    end
  end
end
