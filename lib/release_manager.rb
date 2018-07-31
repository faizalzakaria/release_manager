# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'tty-prompt'
require 'jira-ruby'

require 'release_manager/utils/file_cache'
require 'release_manager/auth_option_builder'
require 'release_manager/notes_generator'
require 'release_manager/release'
require 'release_manager/notifier'

module ReleaseManager
  # Prepare release.
  # This will create a Pull Request in Github
  #
  # Ex.
  #    ReleaseManager.prepare('v3.15.0', sprint: 'v3.15.0 31 Jul')
  #
  # If pr (pull request number) is given,
  # then it will update the Pull Request title and body.
  #
  # Ex.
  #    ReleaseManager.prepare('v3.15.0', sprint: 'v1.0 31 Jul', 2222)
  #
  def prepare
    prompt = TTY::Prompt.new
    result = prompt.collect do
      key(:title).ask('Pull request Title (ex: v3.15.0)', required: true)
      key(:sprint).ask("Sprint (ex: 'v3.15 Jul31')", required: true)
      key(:pr).ask("Pull request number, set this if you need to update pull request (ex: 2222))")
      key(:dry_run).yes?("Dry run?")
    end

    Release
      .new(pr: result[:pr], dry_run: result[:dry_run])
      .prepare(
        result[:title],
        NotesGenerator::generate_from_jira(result[:sprint])
      )
  end

  # Announce the release
  # This will create a Tag, with tag title as the pr title.
  # And tag body as per the PR body.
  #
  # Ex.
  #    ReleaseManager.announce(2222, 'fai')
  def announce
    prompt = TTY::Prompt.new
    result = prompt.collect do
      key(:pr).ask("Pull request number (ex: 2222))", required: true)
      key(:user).ask("Release Manager (ex: 'fai')", required: true)
      key(:dry_run).yes?("Dry run?")
    end

    release = Release.new(pr: result[:pr], dry_run: result[:dry_run])
    if (release.create)
      Notifier.new(
        tag_name: release.tag_name,
        repo: release.repo,
        user: result[:user],
        dry_run: result[:dry_run]
      ).notify
    else
      puts 'Failed to create a release!'
    end
  end

  module_function :prepare, :announce
end
