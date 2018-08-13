# frozen_string_literal: true

module ReleaseManager
  module Client
    #
    # AuthOptionBuilder
    #
    module AuthOptionBuilder
      def build_auth_options
        auth_file_cache.fetch auth_cache_key do
          build_auth_options_by_tty
        end
      end

      def build_auth_options_by_cached
        auth_file_cache.get(auth_cache_key)
      end

      def build_auth_options_by_tty
        raise NotImplementedError
      end

      def expire_auth_options
        auth_file_cache.delete(auth_cache_key)
      end

      private

      def auth_file_cache
        @auth_file_cache ||= FileCache.new('profile')
      end

      def auth_cache_key
        'auth'
      end
    end
  end
end
