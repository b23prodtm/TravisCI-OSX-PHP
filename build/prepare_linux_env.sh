#!/usr/bin/env bash

echo "Here's the Linux environment:"
echo "Adding php support"
curl -L https://raw.githubusercontent.com/phpenv/phpenv-installer/master/bin/phpenv-installer \
    | PHPENV_ROOT=/usr/local/bin/phpenv bash
export PATH="${PHPENV_ROOT}/bin:${PATH}"
eval "$(phpenv init -)"
phpenv global ${_PHP}
phpenv --version
