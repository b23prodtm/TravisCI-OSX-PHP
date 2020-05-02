#!/usr/bin/env bash
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" \
		| sudo tee "/etc/apt/sources.list.d/php${_PHP}.list"
echo "Here's the Linux environment:"
phpenv versions
export ADDITIONAL_PHP_INI=build/.travis_linux.php.ini
