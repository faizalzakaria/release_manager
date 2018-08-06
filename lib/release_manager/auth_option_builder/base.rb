# frozen_string_literal: true

#
# Base
#
module ReleaseManager
  module AuthOptionBuilder
    class Base
      class << self
        def build_auth_options(options = {})
          cache_key = options[:cache_key] || auth_cache_key
          auth_file_cache.fetch cache_key do
            build_auth_options_by_tty(options)
          end
        end

        def build_auth_options_by_cached(options = {})
          cache_key = options[:cache_key] || auth_cache_key
          auth_file_cache.get(cache_key)
        end

        def expire_auth_options
          FileCache.clear_all
        end

        def build_auth_options_by_tty(_options = {})
          raise NotImplementedError
        end

        def auth_file_cache
          @auth_file_cache ||= FileCache.new('profile')
        end

        def auth_cache_key
          'auth'
        end
      end
    end
  end
end
