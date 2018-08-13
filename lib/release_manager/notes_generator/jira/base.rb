# frozen_string_literal: true

require_relative './markdown_renderer'

module ReleaseManager
  module NotesGenerator
    module Jira
      class Base
        attr_reader :sprint, :max_results

        def initialize(sprint:, max_results: 50, custom_jql: nil)
          @sprint      = sprint
          @max_results = max_results
          @jql         = custom_jql
        end

        def generate
          issues = jira.client.Issue.jql(jql, max_results: max_results)
          MarkdownRenderer.new(issues, domain: jira.site, epics: epics).render
        end

        private

        def epics
          @epics ||= begin
                       issues = jira.client.Issue.jql(epics_jql, max_results: 100)
                       issues.each_with_object({}) do |issue, memo|
                         key = issue.attrs['key']
                         memo[key] = issue.attrs['fields']['summary']
                       end
                     end
        end

        def jira
          ReleaseManager::Client::Jira
        end

        def jql
          @jql ||= [
            "project = \"#{jira.project}\"",
            'issuetype in (Bug, Story, Task)',
            'status in (Closed, Done, "For QA review", "For acceptance", "For code review")',
            "Sprint = \"#{sprint}\""
          ].join(' AND ')
        end

        def epics_jql
          @epics_jql ||= "project = \"#{jira.project}\" AND issuetype in (Epic)"
        end
      end
    end
  end
end
