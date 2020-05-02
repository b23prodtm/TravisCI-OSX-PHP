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
    hhvm)
        echo "[NOTE] Cannot install unsupported HHVM dependencies."
        pkg+=([$1]="$1")
        ;;
    php)
        pkg+=([$1]="$1 --version $2")
        export PATH="/c/tools/php$2:${PATH}"
        shift;;
    *)
        pkg+=([$1]="$1");;
  esac;
  if [[ "$#" > 1 ]]; then 
    case "$2" in
      --*) pkg[$1]="${pkg[$1]} -y $2";shift;;
    esac;
  fi;shift
done
choco --version
echo "Updating choco..."
choco upgrade chocolatey
for p in "${!pkg[@]}"; do
    echo "Adding $p support"
    choco install "${pkg[$p]}"
done
powershell refreshenv &
