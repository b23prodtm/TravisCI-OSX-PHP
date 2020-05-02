#!/usr/bin/env bash
if [[ "$#" > 0 ]]; then
    echo "Handling \"$1\" apt package..."
else
    echo "Apt failed - invalid $0 call"
    exit 1;
fi
pkg=$1
if [[ "$#" > 1  && $2 != "latest" ]]; then
  pkg="${pkg}$2"
fi
DEBIAN_FRONTEND="noninteractive"
sudo apt-get update && \
sudo apt-get install -y \
 $pkg && \
echo "**** cleanup ****" && \
sudo rm -rf \
 /tmp/* \
 /var/lib/apt/lists/* \
 /var/tmp/*
