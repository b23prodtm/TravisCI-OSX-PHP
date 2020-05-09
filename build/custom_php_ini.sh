#!/usr/bin/env bash

if [ -z "${ADDITIONAL_PHP_INI}" ]; then
    echo "$0 was called but env. var. ADDITIONAL_PHP_INI is not set!"
    exit 1
fi

if [ ! -f "${ADDITIONAL_PHP_INI}" ]; then
    echo "Custom php.ini path at ${ADDITIONAL_PHP_INI} not found (check ADDITIONAL_PHP_INI env. var.)"
    exit 1
fi
if [[ "${TRAVIS_OS_NAME}" == "windows" ]]; then
  sudo=''
else
  sudo='sudo'
fi
if [[ "${_PKG}" == php* ]]; then
    exec $sudo touch /etc/php.ini
    exec $sudo bash -c "cat ${ADDITIONAL_PHP_INI} >> /etc/php.ini"
    echo "Added php.ini from ${ADDITIONAL_PHP_INI} to /etc/php.ini"
fi
