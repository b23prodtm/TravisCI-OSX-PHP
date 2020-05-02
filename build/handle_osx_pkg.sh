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
    --*) pkg+=("$1"); shift;;
    *);;
  esac
  case "$2" in
    latest)
        pkg+=("$1");;
    *)
        pkg+=("$1@$2");;
  esac;shift;shift
done
if [[ $(brew ls --versions "${pkg}") ]]; then
    if brew outdated "${pkg[@]}"; then
        echo "Package upgrade is not required, skipping"
    else
        echo "Updating package...";
        brew upgrade "${pkg[@]}"
        if [ $? -ne 0 ]; then
            echo "Upgrade failed"
            exit 1
        fi
    fi
else
    echo "Package not available - installing..."
    brew install "${pkg[@]}"
    if [ $? -ne 0 ]; then
        echo "Install failed"
        exit 1
    fi
fi

echo "Linking installed package..."
brew link --force "${pkg[@]}"
