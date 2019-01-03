#!/usr/bin/env bash

echo "Here's the Windows environment:"
choco --version

echo "Updating choco..."
choco upgrade

if [[ "${_PHP}" == "hhvm" ]]; then
    echo "Cannot install unsupported HHVM dependencies."
fi
echo "Adding openssl support"
choco install openssl.light
echo "Adding php support"
curl -L https://raw.githubusercontent.com/phpenv/phpenv-installer/master/bin/phpenv-installer \
    | PHPENV_ROOT=/usr/local/bin/phpenv bash
echo "
export PHPENV_ROOT=\"/usr/local/bin/phpenv\"\n
   if [ -d \"\${PHPENV_ROOT}\" ]; then\n
      export PATH=\${PHPENV_ROOT}/bin:\${PATH}\n
     eval \"\$(phpenv init -)\"\n
   fi" >> ~/.bash_profile
exec $SHELL -l
choco install php --version ${_PHP} -my
export PATH=/c/tools/php$(echo ${_PHP} | cut -c 1,3):${PATH}
