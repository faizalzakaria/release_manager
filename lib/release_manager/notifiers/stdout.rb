# frozen_string_literal: true

module ReleaseManager
  module Notifier
    #
    # Stdout notifier
    #
    class Stdout < Base
      def self.notify(text, release_manager, _opts = {})
        puts '#' * 10
        puts "#{release_manager} ..."
        puts text
        puts '#' * 10
      end
    end
  end
end
