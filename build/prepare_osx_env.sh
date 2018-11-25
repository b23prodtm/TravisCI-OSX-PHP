#!/usr/bin/env bash

echo "Here's the OSX environment:"
sw_vers
brew --version

echo "Updating brew..."
brew update

if [[ "${_PHP}" == "hhvm" ]]; then
    echo "Adding brew HHVM dependencies..."
    brew install hhvm
fi
echo "Adding openssl support"
brew install openssl
