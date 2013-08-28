#!/bin/bash

# Note that this file is intentionally not executable in order to make it less likely it gets
# run by accident on a developer machine.

if [ "$#" -lt 2 ] || [ "$#" -gt 4 ] ; then
  echo "usage: $0 <chef_dir> <node_file.json> <chef_version> <berks_dir>"
  echo ""
  echo "!!! Don't run this on your local workstation! !!!"
  exit 1
fi

CHEF_DIR=$1
NODE_FILE_JSON=$2
CHEF_VERSION=${3:-11.4.4}
BERKS_DIR=${4:-$1}

chef_binary=/usr/bin/chef-solo
berkself_binary=/opt/chef/embedded/bin/berks

# Crash and burn on any errors
set -e

# Install chef if it isn't already installed
if [[ ! -f "$chef_binary" ]] || [[ ! -f "$berkself_binary" ]]; then
    # Dependencies required by berkshelf
    sudo apt-get update
    sudo apt-get install -y make libxslt-dev libxml2-dev gcc git-core curl

    # Install chef
    curl -L https://www.opscode.com/chef/install.sh > /tmp/install-chef.sh
    sudo bash /tmp/install-chef.sh -v ${CHEF_VERSION}
    sudo rm -rf /tmp/install-chef.sh

    # Install berkshelf using the Ruby bundled with chef
    sudo /opt/chef/embedded/bin/gem install --no-ri --no-rdoc berkshelf
fi

# Install dependencies from Berksfile
cd ${BERKS_DIR}
if [ -f Berksfile ]; then
    mkdir -p cookbooks
    "${berkself_binary}" install --path=${CHEF_DIR}/cookbooks
fi

# Run chef to provision server
cd ${CHEF_DIR}

# If chef fails, and tee succeeds, we still want to fail this command
set -o pipefail

command="${chef_binary} -c ./solo.rb -j ${NODE_FILE_JSON}"
echo "Running command ${command}"
echo "Running command ${command}" > /tmp/chef-solo.log
${command} | tee -a /tmp/chef-solo.log
