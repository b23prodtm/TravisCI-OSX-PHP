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
# GPG debian PUBKEY ?
#wget https://packages.sury.org/php/apt.gpg && sudo apt-key add apt.gpg
#echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php7.list
phpenv versions
export ADDITIONAL_PHP_INI=build/.travis_linux.php.ini
