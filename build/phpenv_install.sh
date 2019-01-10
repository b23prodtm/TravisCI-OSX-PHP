#!/usr/bin/env bash
echo "Adding php support"
curl -L https://raw.githubusercontent.com/phpenv/phpenv-installer/master/bin/phpenv-installer | PHPENV_ROOT=/usr/local/bin/phpenv bash
echo "
export PHPENV_ROOT=\"/usr/local/bin/phpenv\"
if [ -d \"\${PHPENV_ROOT}\" ]; then
  export PATH=\${PHPENV_ROOT}/bin:\${PATH}
  eval \"\$(phpenv init -)\"
fi" >> ~/.bash_profile
exec $SHELL -l
