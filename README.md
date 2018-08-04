# ReleaseManager (WIP)

Automation for your release process.

![mnfdkgz6he](https://user-images.githubusercontent.com/3461316/43674373-c5865c20-9805-11e8-84ca-0a3f0be2511f.gif)

## What it does ?

- [x] Given a PR number, it will create a release out of it for you.
- [x] It will copy the PR description/summary into the release notes.
- [x] It will set the release title as your PR title.
- [x] It will notify you (for now only slack & stdout).
- [x] Life should be simple, no headache on configuration, step by step guide just for you.

## Installation
- **Install as a system gem:**
  ```sh
	git clone git@github.com:faizalzakaria/release_manager.git
  cd release_manager
  bundle
  ```
## Usage

### To Prepare a release (This will create a PR in github)

```sh
./exe/release prepare
```
  
### To Announce a release (This will create a Tag in github and announce to slack & stdout)

```sh
./exe/release announce
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/faizalzakaria/release_manager.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
