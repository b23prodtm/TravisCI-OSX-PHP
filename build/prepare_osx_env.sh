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
brew upgrade openssl
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/openssl/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/curl-openssl/lib/pkgconfig"
