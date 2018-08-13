# frozen_string_literal: true

RSpec.describe ReleaseManager::Notifier::Stdout do
  describe '.notify' do
    it 'works' do
      expect { ReleaseManager::Notifier::Stdout.new({}).notify('test', release_manager: 'fai') }
        .to_not raise_exception
    end
  end
end
