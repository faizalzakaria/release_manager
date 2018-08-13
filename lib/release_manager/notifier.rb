# frozen_string_literal: true

require 'json'
require_relative 'notifiers/base'
require_relative 'notifiers/slack'
require_relative 'notifiers/stdout'

module ReleaseManager
  module Notifier
    NOTIFIERS = %w[Slack Stdout].freeze

    def self.notify(text, options)
      NOTIFIERS.each do |notifier|
        klazz = const_get(notifier)
        klazz.notify(text, options)
      end
    end
  end
end
