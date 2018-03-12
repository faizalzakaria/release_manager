RSpec.describe ReleaseManager::Stdout do
  describe '.notify' do
    it 'works' do
      expect { ReleaseManager::Stdout.new({}).notify('test', release_manager: 'fai') }
        .to_not raise_exception
    end
  end
end
