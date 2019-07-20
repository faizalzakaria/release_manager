# frozen_string_literal: true

module ReleaseManager
  #
  # AnnounceService
  #
  class AnnounceService
    class << self
      def run
        create_release(collect_configs)
      end

      private

      def collect_configs
        prompt = TTY::Prompt.new
        prompt.collect do
          key(:pr_id).ask('Pull request number (ex: 2222))', required: true)
          key(:user).ask("Release Manager (ex: 'fai')", required: true)
          key(:dry_run).yes?('Dry run?')
        end
      end

      def create_release(configs)
        release = ReleaseManager::Release.new(pr_id: configs[:pr_id], dry_run: configs[:dry_run])

        if release.create
          ReleaseManager::Notifier.notify(
            Template.create(
              tag_name: release.tag_name,
              repo: ReleaseManager::Client::Github.repo
            ),
            user: configs[:user],
            dry_run: configs[:dry_run]
          )
        else
          puts 'Failed to create a release!'
        end
      rescue => e
        puts release.tag_name
        puts ReleaseManager::Client::Github.repo
        puts e.message
      end
    end
  end
end
