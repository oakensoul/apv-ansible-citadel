#!/bin/bash

echo "Configuring the Server:"
export DEBIAN_FRONTEND=noninteractive

echo "  1/8. Update apt"
apt-get update -qq &> /dev/null || exit 1

echo "  2/8. Install python-software-properties python-apt python-pycurl"
apt-get install -qq software-properties-common python-apt python-pycurl &> /dev/null || exit 1

echo "  3/8. Add Ansible PPA"
apt-add-repository ppa:ansible/ansible &> /dev/null || exit 1

echo "  4/8. Update apt to grab new PPA info for Ansible"
apt-get update -qq &> /dev/null || exit 1

echo "  5/8. Install Ansible"
apt-get install -qq ansible &> /dev/null || exit 1

echo "  6/8. Remove auto-installed packages that are no longer required"
apt-get -y autoremove &> /dev/null || exit 1

echo "  7/8. Upgrading all packages"
apt-get -y dist-upgrade &> /dev/null || exit 1

pwd

echo "  8/8. Running Ansible Galaxy"
ansible-galaxy install -r ../ansible/requirements.txt
