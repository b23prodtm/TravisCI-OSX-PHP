#!/usr/bin/env bash

if [[ "$#" > 0 ]]; then
    echo "Handling \"$1\" brew package..."
else
    echo "Brew failed - invalid $0 call"
    exit 1;
fi
pkg=()
while [[ "$#" > 2 ]]; do
  case "$1" in
    hhvm)
        echo "[NOTE] Cannot install unsupported HHVM dependencies."
        pkg+=("$1 -y $2 $3")
        ;;
    php)
        pkg+=("$1 --version $2 -my $3")
        export PATH="/c/tools/php$(echo ${pkg} | cut -c 1,3):${PATH}"
        ;;
    *)
        pkg+=("$1 -my $3");;
  esac;shift;shift
done
choco --version
echo "Updating choco..."
choco upgrade
echo "Adding ${pkg[@]} support"
for p in "${pkg[@]}"; do
    choco install $p
done
powershell refreshenv&
