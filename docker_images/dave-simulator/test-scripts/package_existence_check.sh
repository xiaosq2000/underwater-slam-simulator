#!/bin/bash
for package_name in "$@"
do
    echo -n "package - $package_name: ";
    if dpkg -l | grep -q $package_name; then
        echo -e '\033[0;32mfound\033[0m'
    else
        echo -e '\033[0;31mnot found\033[0m'
    fi
done
