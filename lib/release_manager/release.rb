# frozen_string_literal: true

require 'octokit'

module ReleaseManager
  #
  # Release
  #
  class Release
    attr_reader :access_token, :pr_id, :repo

    def initialize(options = {})
      @access_token = build_auth_options[:access_token]
      @repo         = build_auth_options[:repo]

      @pr_id        = options[:pr_id]
      @dry_run      = options.fetch(:dry_run, false)
    end

    # Create Pull Request
    def prepare(title, notes)
      return prepare_dry_run(title, notes) if dry_run?

      if pr_id
        update_pr(pr_id, title, notes)
      else
        create_pr(title_notes)
      end
    end

    # Create Tag
    def create
      return create_dry_run if dry_run?

      unless pull_merged?
        puts 'Pull Request is not merged yet'
        return
      end
      create_release
    end

    def tag_name
      @tag_name ||= pull_request.title
    end

    def prepare_dry_run(title, notes)
      puts '-' * 32
      if pr_id
        puts "Updating PR #{pr_id} ..."
      else
        puts 'Creating PR ...'
      end

      puts '-' * 32
      puts title
      puts '-' * 32
      puts notes
    end

    def create_dry_run
      puts '-' * 32
      puts "Creating Tag #{tag_name} ..."
      puts '-' * 32
      true
    end

    def dry_run?
      @dry_run
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

    def create_pr(title, notes)
      github_client.create_pull_request(
        repo,
        'master',
        'develop',
        title,
        notes
      )
    end

    def update_pr(pr_id, title, notes)
      github_client.update_pull_request(
        repo,
        pr_id,
        title: title,
        body: notes
      )
    end

    def create_release
      github_client.create_release(
        repo,
        tag_name,
        body: release_notes,
        name: tag_name,
        draft: false,
        target_commitish: merge_commit_sha
      )
    end

    def build_auth_options
      ReleaseManager::AuthOptionBuilder::Github.build_auth_options
    end
  end
end
