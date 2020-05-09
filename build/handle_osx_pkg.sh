#!/usr/local/bin/bash
# ^ use homebrew bash
if [[ "$#" > 1 ]]; then
    echo "Handling \"$*\" brew package..."
else
    echo "Brew failed - invalid $0 call"
    exit 1;
fi
pkg=()
while [[ "$#" > 1 ]]; do
  case "$1" in
    php)
      # ignore 7.2-xml, and use -> 7.2
      v=$(echo $2 | awk 'BEGIN { FS="-"; } { print $1 }')
      pkg["$1"]="$1@${v}"
      ;;
    *) pkg["$1"]="$1";;
  esac
  if [[ "$#" > 2 ]]; then
    case "$3" in
      --*)shift;;
      *);;
    esac;
  fi
  shift 2
done
if [[ $(brew ls --versions "${!pkg[@]}") ]]; then
  echo "Package(s) need update, uninstalling...";
  brew uninstall "${pkg[@]}"
  if [ $? -ne 0 ]; then
      echo "Uninstall failed"
  fi
fi
echo "Package(s) ${!pkg[@]} not available - installing..."
brew install "${pkg[@]}"
if [ $? -ne 0 ]; then
    echo "Install failed"
fi
echo "Linking ${!pkg[@]} package(s)..."
brew link --force "${!pkg[@]}" || bash --version
