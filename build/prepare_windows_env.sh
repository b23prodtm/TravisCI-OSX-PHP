#!/usr/bin/env bash

echo "Here's the Windows environment:"
echo "Fixing phpenv support"
export PATH="/c/Program Files/git${PHPENV_ROOT}/libexec:${PATH}"
# eval "$(phpenv init -)"

choco --version
echo "Updating choco..."
choco upgrade

if [[ "${_PHP}" == "hhvm" ]]; then
    echo "Cannot install unsupported HHVM dependencies."
fi
choco install php --version ${_PHP} -my --with-openssl
export PATH="/c/tools/php$(echo ${_PHP} | cut -c 1,3):${PATH}"

echo "Adding openssl support"
choco install openssl.light
