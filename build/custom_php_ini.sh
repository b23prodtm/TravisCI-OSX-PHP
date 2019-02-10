#!/usr/bin/env bash

if [ -z "${ADDITIONAL_PHP_INI}" ]; then
    echo "$0 was called but env. var. ADDITIONAL_PHP_INI is not set!"
    exit 1
fi

if [ ! -f "${ADDITIONAL_PHP_INI}" ]; then
    echo "Custom php.ini path at ${ADDITIONAL_PHP_INI} not found (check ADDITIONAL_PHP_INI env. var.)"
    exit 1
fi

if [[ "${_PKG}" == php* ]]; then
    sudo touch /etc/php.ini
    sudo bash -c "cat ${ADDITIONAL_PHP_INI} >> /etc/php.ini"
    echo "Added php.ini from ${ADDITIONAL_PHP_INI} to /etc/php.ini"

elif [[ "${_PHP}" == hhv* ]]; then
    sudo touch /etc/hhvm/php.ini
    sudo bash -c "cat ${ADDITIONAL_PHP_INI} >> /etc/hhvm/php.ini"
    echo "Added php.ini content from ${ADDITIONAL_PHP_INI} to /etc/hhvm/php.ini"
fi
