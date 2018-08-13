# frozen_string_literal: true

module ReleaseManager
  module Notifier
    #
    # Base notifier
    #
    class Base
      def self.notify(_text, _user, _opts = {})
        raise NotImplementedError
      end
    end
  end
end
