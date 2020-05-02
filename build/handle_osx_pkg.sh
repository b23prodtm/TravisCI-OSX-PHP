#!/usr/bin/env bash
if [[ "$#" > 1 ]]; then
    echo "Handling \"$1\" brew package..."
else
    echo "Brew failed - invalid $0 call"
    exit 1;
fi
pkg=()
while [[ "$#" > 1 ]]; do
  case "$1" in
    php) set -- "$1" $(echo "$2" | awk 'BEGIN { FS="." } { print $1$2 }') "${@:3}";;
    *);;
  esac
  case "$2" in
    *-xml);;
    latest)
        pkg+=([$1]="$1");;
    *)
        pkg+=([$1]="$1@$2");;
  esac;
  if [[ "$#" > 2 ]]; then 
    case "$3" in
      --*) pkg[$1]="${pkg[$1]} $3"; shift;;
      *);;
    esac;
  fi;shift 2
done
if [[ $(brew ls --versions "${pkg}") ]]; then
    if brew outdated "${!pkg[*]}"; then
        echo "Package upgrade is not required, skipping"
    else
        echo "Updating package...";
        brew upgrade "${!pkg[*]}"
        if [ $? -ne 0 ]; then
            echo "Upgrade failed"
        fi
    fi
else
    echo "Package not available - installing..."
    brew install "${pkg[*]}"
    if [ $? -ne 0 ]; then
        echo "Install failed"
    fi
fi

echo "Linking installed package..."
brew link --force "${pkg[@]}"
