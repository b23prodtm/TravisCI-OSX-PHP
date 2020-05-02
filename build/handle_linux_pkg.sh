#!/usr/bin/env bash
if [[ "$#" > 0 ]]; then
    echo "Handling \"$@\" apt packages..."
else
    echo "Apt failed - invalid $0 call"
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
        pkg+=("$1$2");;
  esac;shift;shift
done
DEBIAN_FRONTEND="noninteractive"
sudo apt-get update && \
sudo apt-get install -y \
 "${pkg[@]}" && \
echo "**** cleanup ****" && \
sudo rm -rf \
 /tmp/* \
 /var/lib/apt/lists/* \
 /var/tmp/*
