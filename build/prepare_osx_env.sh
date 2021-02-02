#!/usr/bin/env bash
echo "Here's the OSX environment:"
sw_vers

echo "Updating bash..."
brew install --build-from-source bash || true
brew link --force bash || true
sudo chsh -s /usr/local/bin/bash $USER
bash --version

echo "Adding openssl support"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/openssl/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/curl-openssl/lib/pkgconfig"
echo "Downloading cacert.pem..."
curl -sSL http://curl.haxx.se/ca/cacert.pem >> cacert.pem
mkdir -p /usr/local/etc/openssl/certs
mv -v cacert.pem /usr/local/etc/openssl/certs
export ADDITIONAL_PHP_INI=build/.travis_osx.php.ini
echo "openssl.cafile=/usr/local/etc/openssl/certs/cacert.pem" >> ${ADDITIONAL_PHP_INI}
