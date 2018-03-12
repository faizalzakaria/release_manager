# coding: utf-8
module ReleaseManager
  class Slack
    attr_reader :webhook_url, :channel

    def initialize(option)
      @webhook_url = option[:webhook_url]
      @channel     = option[:channel] || '#news'
      @dry_run     = option[:dry_run] || false
    end

    def notify(text, release_manager:)
      encoded_params = "payload=#{build_payload(text, release_manager)}"
      if @dry_run
        puts "curl -X POST --data-urlencode '#{encoded_params}' #{@webhook_url}"
      else
        `curl -X POST --data-urlencode '#{encoded_params}' #{@webhook_url}`
      end
    end

    private

    def build_payload(text, release_manager)
      {
        channel: @channel,
        username: release_manager,
        text: text,
      }.to_json.to_s
    end
  end
end
