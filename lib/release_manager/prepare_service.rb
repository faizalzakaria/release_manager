# frozen_string_literal: true

module ReleaseManager
  #
  # PrepareService
  #
  class PrepareService
    class << self
      def run
        prepare_release(collect_configs)
      end

      private

      def collect_configs
        prompt = TTY::Prompt.new
        configs = prompt.collect do
          key(:title).ask('Pull request Title (ex: v3.15.0)', required: true)
          key(:custom_jql).ask('Custom JQL (set this if you need to do a custom jql, leave empty otherwise)')
        end

        if configs[:custom_jql].nil?
          configs.merge!(
            prompt.collect do
              key(:sprint).ask("Sprint (ex: 'v3.15 Jul31')", required: true)
            end
          )
        end

        configs.merge!(
          prompt.collect do
            key(:pr_id).ask('Pull request number, set this if you need to update pull request (ex: 2222))')
            key(:from_branch).ask('From which branch ?', default: 'develop')
            key(:to_branch).ask('To which branch ?', default: 'master')
            key(:dry_run).yes?('Dry run?')
          end
        )

        configs
      end

      def prepare_release(configs)
        Release.new(
          pr_id: configs[:pr_id],
          dry_run: configs[:dry_run],
          from_branch: configs[:from_branch],
          to_branch: configs[:to_branch]
        ).prepare(
          configs[:title],
          NotesGenerator.generate_from_jira(
            configs[:sprint],
            configs[:custom_jql]
          )
        )
      end
    end
  end
end
