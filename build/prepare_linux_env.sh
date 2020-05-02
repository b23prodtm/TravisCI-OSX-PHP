#!/usr/bin/env bash
echo "Here's the Linux environment:"
DEBIAN_FRONTEND="noninteractive"
sudo apt-get update && \
sudo apt-get install -y \
		software-properties-common \
		dirmngr \
		apt-transport-https \
		lsb-release \
		ca-certificates && \
echo "**** cleanup ****" && \
sudo rm -rf \
 /tmp/* \
 /var/lib/apt/lists/* \
 /var/tmp/*
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
phpenv versions
export ADDITIONAL_PHP_INI=build/.travis_linux.php.ini
