# coding: utf-8
module ReleaseManager
    class Stdout
      def initialize(_option = {})
        # Do nothing
      end

      def notify(text, release_manager:)
        puts '#' * 10
        puts "#{release_manager} ..."
        puts text
        puts '#' * 10
      end
  end
end
