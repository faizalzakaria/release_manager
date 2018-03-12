RSpec.describe ReleaseManager::Slack do
  describe '.notify' do
    it 'works' do
      expect { ReleaseManager::Slack.new({ dry_run: true }).notify('test', release_manager: 'fai') }
        .to_not raise_exception
    end
  end
end
