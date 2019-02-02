#!/usr/bin/env bash

if [ -z "${ADDITIONAL_PHP_INI}" ]; then
    echo "$0 was called but env. var. ADDITIONAL_PHP_INI is not set!"
    exit 1
fi

if [ ! -f "${ADDITIONAL_PHP_INI}" ]; then
    echo "Custom php.ini path at ${ADDITIONAL_PHP_INI} not found (check ADDITIONAL_PHP_INI env. var.)"
    exit 1
fi

if [[ ("${TRAVIS_OS_NAME}" == "osx") || ("${TRAVIS_OS_NAME}" == "windows") ]]; then
    if [[ "${_PKG}" == php* ]]; then
        phpenv config-add "${ADDITIONAL_PHP_INI}"
        echo "Added php.ini from ${ADDITIONAL_PHP_INI} to phpenv"

    elif [[ "${_PHP}" == hhv* ]]; then
        cat build/.travis.php.ini >> /etc/hhvm/php.ini
        echo "Added php.ini content from ${ADDITIONAL_PHP_INI} to /etc/hhvm/php.ini"
    fi
elif [[ "${TRAVIS_OS_NAME}" == "linux" ]]; then
    if [[ "${TRAVIS_PHP_VERSION}" == php* ]]; then
        phpenv config-add "${ADDITIONAL_PHP_INI}"
        echo "Added php.ini from ${ADDITIONAL_PHP_INI} to phpenv"

    elif [[ "${TRAVIS_PHP_VERSION}" == hhv* ]]; then
        cat build/.travis.php.ini >> /etc/hhvm/php.ini
        echo "Added php.ini content from ${ADDITIONAL_PHP_INI} to /etc/hhvm/php.ini"
    fi
fi
