# abc
Simply your build actions with Apt, Brew, and Choco dependencies in one action. Easy as ABC!
### Motivation
Setting up a GitHub Action to build your project is fairly easy. One of the most
useful tools for a cross-platform build job is GitHub Actions's 
`job.strategy.matrix`, which allows you to run the same build steps on multiple
platforms. However, if you have platform-specific dependencies, it can be a pain 
to manage, as you have to add a new action for each platform, and check the 
runner's platform in each step. This conflicts with the goal of having a single
build step that runs on all platforms. Enter `abc`, a simple build action that
automates the process of adding platform-specific dependencies to your build via
`apt`, `brew`, and `choco`. Makes platform-specific dependencies easy as ABC!

## Getting Started
### Add a `lyricwulf/abc` step to your job to install dependencies:
```yml
- uses: lyricwulf/abc@v1
  with: 
    linux: libfoo
    macos: mac-lib
    windows: win-lib
```
### Specify multiple dependencies in one line:
```yml
  with: 
    linux: libfoo libbar libbaz
```
### Specify dependencies for Unix-like or all platforms:
`libfoo` and `libbar` are installed for MacOS and Linux. `libbaz` and `liblyric`
are installed for Linux, Windows, and MacOS.
```yml
  with:
    unix: libfoo libbar
    all: libbaz liblyric
```
### Specify package version:
Target a specific version of a dependency using @ and a version constraint.
```yml
  with:
    linux: libfoo@1.2.3
    macos: libbar@4.2.0
    windows: libbaz@0.6.9-nice
```

## Example Use
Write cross platform jobs using `job.strategy.matrix` and abc:
```yml
jobs:
  foo:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        include: 
          - os: windows-latest
          - os: macos-latest
          - os: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: lyricwulf/abc@v1
        with:
          windows: lib-from-choco
          macos: lib-from-brew
          linux: libfoo
```

## Contributing
Any and all contributions are welcome! Please open an issue or a pull request.

## Todo
- Add [automatic dependency caching](https://docs.github.com/en/actions/guides/caching-dependencies-to-speed-up-workflows)
> This feature would require this action to be re-written as a node action since
we cannot use actions/cache for composite actions. This is a [GitHub Actions 
limitation](https://github.com/actions/runner/issues/862).