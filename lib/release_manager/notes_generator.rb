# frozen_string_literal: true

require_relative './notes_generator/jira/base'

#
# NotesGenerator
#

module ReleaseManager
  module NotesGenerator
    # Return string as markdown
    def generate_from_jira(sprint, custom_jql = nil)
      Jira::Base.new(sprint: sprint, custom_jql: custom_jql).generate
    end

    module_function :generate_from_jira
  end
end
