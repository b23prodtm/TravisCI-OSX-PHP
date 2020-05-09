#!/usr/bin/env bash

if [[ "$#" > 0 ]]; then
    echo "Handling \"$*\" choco package..."
else
    echo "Chocolatey failed - missing arguments"
    exit 1;
fi
pkg=()
while [[ "$#" > 1 ]]; do
  case "$1" in
    php)
      # ignore 7.2-xml, and use -> 7.2
      v=$(echo $2 | awk "BEGIN { FS=\"-\"; } { print \$1 \".0\" }")
      pkg+=(["$1"]="$1 --version=${v} --package-parameters='\"/DontAddToPath /ThreadSafe /InstallDir:/c/php\"'")
      # pkg+=(["$1"]="$1 --version=${v} --package-parameters='\"/DontAddToPath /ThreadSafe /InstallDir:/c/php\"'")
      # bkpIFS="${IFS}"
      # IFS=':'
      # P=("/c/tools/php/:${PATH}")
      # printf "PATH=%s\n" "${P[@]}"
      # export PATH="${P[@]}"
      # IFS="${bkpIFS}"
      ;;
    composer)
      pkg["$1"]="$1 --ia '\"/DEV=/c/tools/php /PHP=/c/php\"'"
      ;;
    *)
      pkg["$1"]="$1";;
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
echo "Adding ${!pkg[@]} support..."
for p in "${pkg[@]}"; do
    choco install "${p}"
done
powershell refreshenv &
cat /c/ProgramData/chocolatey/logs/chocolatey.log | tail -n 100
