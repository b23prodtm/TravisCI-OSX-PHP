#!/usr/bin/env bash

echo "Here's the Windows environment:"
echo "Fixing phpenv support"
export PATH="/c/Program Files/git${PHPENV_ROOT}/libexec:${PATH}"
#phpenv init -
phpenv rehash 2>/dev/null
phpenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  shell)
    eval `phpenv "sh-$command" "$@"`;;
  *)
    command phpenv "$command" "$@";;
  esac
}
echo "Downloading cacert.pem..."
curl -sSL http://curl.haxx.se/ca/cacert.pem >> cacert.pem
mkdir -p /usr/local/etc/openssl/certs
mv -v cacert.pem /usr/local/etc/openssl/certs
export ADDITIONAL_PHP_INI=build/.travis_windows.php.ini
