module ReleaseManager
  def self.release(options)
    ReleaseManager::Base.new(options).release
  end
end
