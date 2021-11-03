#!/bin/bash
echo "Updating brew..."
brew update

echo "Upgrading all brew packages..."
if [ "$ABC_CFG_UPGRADE_ALL" == "true" ] 
then
    brew upgrade
fi

echo "Installing MacOS dependencies:"
echo "  $ABC_DEPS"
# Install brew deps. Reason for the NO_AUTO_UPDATE is the below discussion
# https://github.com/Homebrew/discussions/discussions/57
# Brew version syntax is already libxyz@1.2.3 (same as ours)
HOMEBREW_NO_AUTO_UPDATE=1 command brew install $ABC_DEPS