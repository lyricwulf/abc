# abc
Simply your build actions with Apt, Brew, and Choco dependencies in one action. Easy as ABC!
### Motivation
Setting up a GitHub Action to build your project is fairly easy. One of the most
useful tools for a cross-platform build job is GitHub Actions's 
`job.strategy.matrix`, which allows you to run the same build steps on multiple
platforms. However, if you have platform-specific dependencies, it can be a pain 
to manage, as you have to add a new action for each platform, and check the 
runner's platform in each step 
(
[Here](https://github.com/starship/starship/blob/cc32c7214bf94651cd456390cf40f0af27c35c1f/.github/workflows/workflow.yml#L117) 
[are](https://github.com/starship/starship/blob/cc32c7214bf94651cd456390cf40f0af27c35c1f/.github/workflows/workflow.yml#L117) 
[some](https://github.com/bevyengine/bevy/blob/main/.github/workflows/ci.yml#L35)
[examples](https://github.com/dexplo/dataframe_image/blob/6d3707f81e57d3a7a5d83ccd7cc858f3501e7293/.github/workflows/python-package.yml#L34)
[of](https://github.com/gfx-rs/wgpu/blob/e5142b3cdc4abece5e85b6983064deb395ffb922/.github/workflows/ci.yml#L102)
[this](https://github.com/dexplo/dataframe_image/blob/6d3707f81e57d3a7a5d83ccd7cc858f3501e7293/.github/workflows/python-package.yml#L34)
[in](https://github.com/robotology/icub-main/blob/e1aa1df223d74ef8c1518247df264f281f59bf18/.github/workflows/ci.yml#L38)
[the](https://github.com/robotology/icub-main/blob/e1aa1df223d74ef8c1518247df264f281f59bf18/.github/workflows/ci.yml#L50)
[wild](https://github.com/robotology/icub-main/blob/e1aa1df223d74ef8c1518247df264f281f59bf18/.github/workflows/ci.yml#L55)
). 
This conflicts with the goal of having a single build step that runs on all 
platforms. Enter `abc`, a simple build action that automates the process of 
adding platform-specific dependencies to your build via `apt`, `brew`, and 
`choco`. Let's make platform-specific dependencies easy as ABC!

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
