#!/usr/bin/env ruby

require 'optparse'
require 'octokit'

options = {
  repo: 'faizalzakaria/test_release',
  access_token: '31460fbd50c16cfd9f896cc81aab08d70f9eba41',
  tag_name: nil,
  pr_number: nil
}

op = OptionParser.new do |opts|
  opts.banner = <<~END
  Usage: generate_release -r <faizalzakaria/release_manager>
                          -t <v3.0.0>
                          -n <1>
                          -a <1341jkh5315jk3h5>

  Generate release for a given PR number.

  END

  opts.on('-r', '--repo <faizalzakaria/release_manager>', 'Repo') do |v|
    options[:repo] = v
  end
  opts.on('-t', '--tag_name <v3.0.0>', 'Tag name of your release') do |v|
    options[:tag_name] = v
  end
  opts.on('-n', '--pr_number <1>', 'Pull request number') do |v|
    options[:pr_number] = v
  end
  opts.on('-a', '--access_token <34141k4jhkh>', 'Access Token') do |v|
    options[:pr_number] = v
  end
end
op.parse!

unless options[:repo] && options[:pr_number] && options[:access_token]
  puts op.help
  exit 16
end

class Client
  attr_reader :access_token, :pr_number, :tag_name, :repo

  def initialize(options)
    @access_token = options[:access_token]
    @pr_number    = options[:pr_number]
    @tag_name     = options[:tag_name]
    @repo         = options[:repo]
  end

  def client
    @client ||= Octokit::Client.new(:access_token => access_token)
  end

  def pull_merged?
    client.pull_merged?(repo, pr_number)
  end

  def pull_request
    client.close_pull_request(repo, pr_number)
  end

  def merge_commit_sha
    pull_request.merge_commit_sha
  end

  def release_notes
    pull_request.body
  end

  def tag_name
    @tag_name || pull_request.title
  end

  def create_release
    client.create_release(repo, tag_name, body: release_notes, name: tag_name, draft: false, target_commitish: merge_commit_sha)
  end

  def release
    unless pull_merged?
      puts 'Pull Request is not merged yet'
      return
    end
    create_release
  end
end

client = Client.new(options)
client.release
