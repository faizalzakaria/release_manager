require 'release_manager/base'

module ReleaseManager
  def self.release(options)
    ReleaseManager::Base.new(options).release
  end
end
