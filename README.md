# ReleaseManager (WIP)

Automation for your release process.

## What it does ?

- [x] Given a PR number, it will create a release out of it for you.
- [x] It will copy the PR description/summary into the release notes.
- [x] It will set the release title as your PR title.
- [x] It will notify you (for now only slack & stdout).

## Installation
- **Install as a system gem:**
  ```sh
	git clone git@github.com:faizalzakaria/release_manager.git
  cd release_manager
  bundle
  ```
## Usage
- **Create a config.yml**
  ```sh
  touch config.yml
  ```
  ```sh
  :repo: [Insert github repo name here]
  :access_token: [Insert access token here]
  :release_manager: [Insert your name here]
  :notifiers:
    :slack:
      :enabled: true
      :webhook_url: [Insert slack webhook here]
      :channel: [Insert slack channel here]
    :stdout:
      :enabled: true
  ```
  - Repo
    - 'myprojects/sample-project'
  - Access token
    - In Github, you can generate one here: https://github.com/settings/tokens
    - **Generate new token** → **Check 'repo'** → **Generate token**
  - Slack webhook
      - In Slack, you can create webhooks here: https://get.slack.help/hc/en-us/articles/115005265063-Incoming-WebHooks-for-Slack#set-up-incoming-webhooks
      - Should look like: 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX'
  - Slack channel
    - Should look like: '#news'

- **Run it**
  ```sh
  ./exe/release -c config.yml -n [Insert pull request number]
  ```
  - Pull request number
    - https://github.com/my-projects/sample-project/pull/1744
    - PR number should look like: 1744

## Pre-requisites

```shell
cp config.yml.example config.yml
```

## How To ?

```shell
release -c config.yml -n 1
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/faizalzakaria/release_manager.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
