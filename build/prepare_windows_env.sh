#!/usr/bin/env bash

echo "Here's the Windows environment:"
choco --version

echo "Updating choco..."
choco update

if [[ "${_PHP}" == "hhvm" ]]; then
    echo "Cannot install unsupported HHVM dependencies."
fi
echo "Adding openssl support"
choco install openssl.light
echo "Adding php support"
choco install php --version ${_PHP} -my
export PATH=/c/tools/php$(echo ${_PHP} | cut -c 1,3):$PATH