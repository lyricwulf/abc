# abc
Simply your build actions with Apt, Brew, and Choco dependencies in one action. Easy as ABC!

## Usage
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
      - uses: lyricwulf/abc@v1
        with: 
          linux: libfoo bar-cli
          macos: lib-from-brew other-lib
          windows: lib-from-choco another-lib
          # Can also do combo of platforms
          unix: lib-for-linux-and-mac not-for-windows
          all: cross-platform-lib
```