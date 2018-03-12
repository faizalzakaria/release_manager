# ReleaseManager (WIP)

Automation for your release process.

## What it does ?

- [x] Given a PR number, it will create a release out of it for you.
- [x] It will copy the PR description/summary into the release notes.
- [x] It will set the release title as your PR title.
- [x] It will notify you (for now only slack & stdout).

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
