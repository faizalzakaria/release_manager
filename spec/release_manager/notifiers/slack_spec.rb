# frozen_string_literal: true

RSpec.describe ReleaseManager::Notifier::Slack do
  describe '.notify' do
    it 'works' do
      expect { ReleaseManager::Notifier::Slack.new(dry_run: true).notify('test', release_manager: 'fai') }
        .to_not raise_exception
    end
  end
end
