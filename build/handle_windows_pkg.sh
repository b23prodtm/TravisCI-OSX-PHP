#!/usr/bin/env bash

if [[ "$#" > 0 ]]; then
    echo "Handling \"$1\" choco package..."
else
    echo "Chocolatey failed - missing arguments"
    exit 1;
fi
pkg=()
while [[ "$#" > 1 ]]; do
  case "$1" in
    php)
        pkg+=([$1]="$1 --version $2")
        export PATH="/c/tools/php$2:${PATH}"
        ;;
    *)
        pkg+=([$1]="$1");;
  esac
  if [[ "$#" > 2 ]]; then case "$3" in
      --*) shift;;
      *);;
  esac; fi
  shift 2
done
choco --version
echo "Updating choco..."
choco upgrade chocolatey
for p in "${!pkg[@]}"; do
    echo "Adding $p support"
    choco install "${pkg[$p]}"
done
powershell refreshenv &
