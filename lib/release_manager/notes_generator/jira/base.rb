# frozen_string_literal: true

require_relative './markdown_renderer'

module ReleaseManager
  module NotesGenerator
    module Jira
      class Base
        attr_reader :project, :sprint, :max_results

        def initialize(sprint:, max_results: 50, custom_jql: nil)
          @project     = build_auth_options[:project]
          @sprint      = sprint
          @max_results = max_results
          @jql         = custom_jql
        end

        def generate
          issues = client.Issue.jql(jql, max_results: max_results)
          MarkdownRenderer.new(issues, domain: build_auth_options[:site], epics: epics).render
        end

        def epics
          @epics ||= begin
                       issues = client.Issue.jql(epics_jql, max_results: 100)
                       issues.reduce({}) do |memo, issue|
                         key = issue.attrs['key']
                         memo[key] = issue.attrs['fields']['summary']
                         memo
                       end
                     end
        end

        private

        def client
          @client ||= JIRA::Client.new(build_auth_options)
        end

        def jql
          @jql ||= "project = \"#{project}\" AND issuetype in (Bug, Story, Task) AND status in (Closed, Done, \"For QA review\", \"For acceptance\", \"For code review\") AND Sprint = \"#{sprint}\""
        end

        def epics_jql
          @epics_jql ||= "project = \"#{project}\" AND issuetype in (Epic)"
        end

        def build_auth_options
          ReleaseManager::AuthOptionBuilder::Jira.build_auth_options
        end
      end
    end
  end
end
