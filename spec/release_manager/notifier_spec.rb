# frozen_string_literal: true

RSpec.describe ReleaseManager::Notifier do
  it { expect(ReleaseManager::Notifier::NOTIFIERS).to eql(%w[slack stdout]) }

  describe '.notify' do
    let(:params) do
      {
        repo: 'test',
        tag_name: 'v1',
        release_manager: 'fai',
        options: {}
      }
    end

    context 'all is enabled' do
      let(:new_params) { params.merge(options: { slack: { enabled: true }, stdout: { enabled: true } }) }

      it 'notify all the notifiers' do
        expect_any_instance_of(ReleaseManager::Slack).to receive(:notify)
        expect_any_instance_of(ReleaseManager::Stdout).to receive(:notify)

        ReleaseManager::Notifier.new(new_params).notify
      end
    end

    context 'none is enabled' do
      it 'notify none of the notifiers' do
        expect_any_instance_of(ReleaseManager::Slack).to_not receive(:notify)
        expect_any_instance_of(ReleaseManager::Stdout).to_not receive(:notify)

        ReleaseManager::Notifier.new(params).notify
      end
    end
  end
end
