# frozen_string_literal: true

module ReleaseManager
  #
  # Stdout notifier
  #
  class Stdout
    def initialize
      # Do nothing
    end

    def notify(text, release_manager, _opts = {})
      puts '#' * 10
      puts "#{release_manager} ..."
      puts text
      puts '#' * 10
    end
  end
end
