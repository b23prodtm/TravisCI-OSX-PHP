#!/usr/bin/env bash
if [[ "$#" > 0 ]]; then
    echo "Handling \"$@\" apt packages..."
else
    echo "Apt failed - invalid $0 call"
    exit 1;
fi
pkg=()
while [[ "$#" > 1 ]]; do
  case "$2" in
    latest)
        pkg+=([$1]="$1");;
    *)
        pkg+=([$1]="$1$2");;
  esac;
  if [[ "$#" > 2 ]]; then
    case "$3" in
      --*) shift;;
      *);;
    esac;
  fi;shift 2
done
DEBIAN_FRONTEND="noninteractive"
sudo apt-get -q update && \
sudo apt-get install -y \
 "${pkg[*]}" && \
echo "**** cleanup ****" && \
sudo rm -rf \
 /tmp/* \
 /var/lib/apt/lists/* \
 /var/tmp/*
