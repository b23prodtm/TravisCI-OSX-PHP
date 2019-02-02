#!/usr/bin/env bash

echo "Here's the Linux environment:"
phpenv global ${_PHP}
phpenv --version
export ADDITIONAL_PHP_INI=build/.travis_linux.php.ini
