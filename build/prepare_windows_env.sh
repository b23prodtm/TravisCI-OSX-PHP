#!/usr/bin/env bash

echo "Here's the Windows environment:"
choco --version

echo "Updating choco..."
choco upgrade

if [[ "${_PHP}" == "hhvm" ]]; then
    echo "Cannot install unsupported HHVM dependencies."
fi
echo "Adding openssl support"
choco install openssl.light
echo "Adding php support"
curl -L https://raw.githubusercontent.com/phpenv/phpenv-installer/master/bin/phpenv-installer \
    | PHPENV_ROOT=/usr/local/bin/phpenv bash
export PATH="${PHPENV_ROOT}/bin:${PATH}"
eval "$(phpenv init -)"
choco install php --version ${_PHP} -my
export PATH=/c/tools/php$(echo ${_PHP} | cut -c 1,3):${PATH}
