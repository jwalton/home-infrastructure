#!/bin/bash

usage(){
    echo "Usage: $0 [host] [nodefile]"
    echo
    echo "host     - SSH-style host to deploy to. (e.g. jason@github.com)"
    echo "nodefile - Path (relative to chef dir) of node.json file."
    echo "           Defaults to 'nodes/default.json'"
    exit 1
}

[[ $# -eq 0 ]] && usage

host="${1}"
nodefile="${2:-nodes/default.json}"

echo "Using nodefile ${nodefile}"

# The host key might change when we instantiate a new VM, so
# we remove (-R) the old host key from known_hosts
ssh-keygen -R "${host#*@}" 2> /dev/null

tar cj . | ssh -o 'StrictHostKeyChecking no' "$host" "
sudo rm -rf ~/chef &&
mkdir ~/chef &&
cd ~/chef &&
tar xj &&
sudo bash chef-install.sh . ./${nodefile}"