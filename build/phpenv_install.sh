#!/usr/bin/env bash
echo "Adding phpenv support"
curl -L https://raw.githubusercontent.com/phpenv/phpenv-installer/master/bin/phpenv-installer | bash
echo "
export PHPENV_ROOT=\"${PHPENV_ROOT}\"
if [ -d \"\${PHPENV_ROOT}\" ]; then
  export PATH=\"\${PHPENV_ROOT}/bin:\${PATH}\"
  eval \"\$(phpenv init -)\"
fi" >> ~/.bash_profile
source ~/.bash_profile
# exec $SHELL -l #; uncompatible in CI bash
