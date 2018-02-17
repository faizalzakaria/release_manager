require 'octokit'

module ReleaseManager
  class Release
    attr_reader :access_token, :pr_number, :repo

    def initialize(options)
      @access_token = options[:access_token]
      @pr_number    = options[:pr_number]
      @tag_name     = options[:tag_name]
      @repo         = options[:repo]
    end

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
      github_client.pull_merged?(repo, pr_number)
    end

    def pull_request
      github_client.close_pull_request(repo, pr_number)
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
  end
end
