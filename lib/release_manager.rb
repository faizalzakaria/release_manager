# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'thor'
require 'tty-prompt'
require 'jira-ruby'
require 'release_manager/notes_generator'
require 'release_manager/release'
require 'release_manager/template'
require 'release_manager/notifier'
require 'release_manager/prepare_service'
require 'release_manager/announce_service'
require 'release_manager/reset_cli'
require 'release_manager/cli'
require 'release_manager/client'

#
# ReleaseManager module
#
module ReleaseManager
end
