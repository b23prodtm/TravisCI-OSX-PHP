#!/usr/bin/env bash

echo "Here's the Linux environment:"
phpenv global ${_PHP}
composer self-update
phpenv --version
composer --version
