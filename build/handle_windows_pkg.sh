#!/usr/bin/env bash

if [[ "$#" > 0 ]]; then
    echo "Handling \"$1\" brew package..."
else
    echo "Brew failed - invalid $0 call"
    exit 1;
fi
pkg=$1
version=$2
args=$3
choco --version
echo "Updating choco..."
choco upgrade
echo "Adding ${pkg} support"
case "$pkg" in
  "hhvm")
    echo "Cannot install unsupported HHVM dependencies."
    args="${version} ${args}"
    choco install $pkg -y $args;;
  "php")
    choco install $pkg --version $version -my $args
    export PATH="/c/tools/php$(echo ${pkg} | cut -c 1,3):${PATH}";;
  *) choco install $pkg -my $args;;
esac
powershell refreshenv
