# frozen_string_literal: true

module ReleaseManager
  #
  # Template for announcement
  #
  class Template
    def self.create(tag_name:, repo:)
      new(tag_name: tag_name, repo: repo).to_s
    end

    attr_reader :tag_name, :repo

    def initialize(tag_name:, repo:)
      @tag_name = tag_name
      @repo     = repo
    end

    def to_s
      <<~DEFAULT_TEMPLATE
        :tada: *#{tag_name}* · _#{date_today}_
        > More info can be found here,
        > *Changelog*: #{release_url}
      DEFAULT_TEMPLATE
    end

    private

    def github_url
      'https://github.com/'
    end

    def release_url
      github_url + repo + '/releases/tag/' + tag_name
    end

    def date_today
      Time.now.strftime('%b %d')
    end
  end
end
