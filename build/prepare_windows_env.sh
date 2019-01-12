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


choco --version
echo "Updating choco..."
choco upgrade

if [[ "${_PHP}" == "hhvm" ]]; then
    echo "Cannot install unsupported HHVM dependencies."
    choco install php -y --with-openssl
else
    choco install php --version ${_PHP} -my --with-openssl
fi
export PATH="/c/tools/php$(echo ${_PHP} | cut -c 1,3):${PATH}"

echo "Adding openssl support"
choco install openssl.light
powershell refreshenv
