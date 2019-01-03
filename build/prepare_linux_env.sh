#!/usr/bin/env bash

echo "Here's the Linux environment:"
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
phpenv global ${_PHP}
phpenv --version
