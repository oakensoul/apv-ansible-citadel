#!/bin/bash

echo "Configuring the Server:"
export DEBIAN_FRONTEND=noninteractive

echo "  Setup 1/9. Update apt"
apt-get update -qq &> /dev/null || exit 1

echo "  Setup 2/9. Install python-software-properties python-apt python-pycurl"
apt-get install -qq software-properties-common python-apt python-pycurl &> /dev/null || exit 1

echo "  Setup 3/9. Add Ansible PPA"
apt-add-repository ppa:ansible/ansible &> /dev/null || exit 1

echo "  Setup 4/9. Update apt to grab new PPA info for Ansible"
apt-get update -qq &> /dev/null || exit 1

echo "  Setup 5/9. Install Ansible"
apt-get install -qq ansible &> /dev/null || exit 1

echo "  Setup 6/9. Remove auto-installed packages that are no longer required"
apt-get -y autoremove &> /dev/null || exit 1

echo "  Setup 7/9. Upgrading all packages"
apt-get -y dist-upgrade &> /dev/null || exit 1

echo "  Setup 8/9. Updating sudoers"
echo '%sudo    ALL=(ALL)  NOPASSWD:ALL' >> /etc/sudoers

echo "  Setup 9/9. Running Ansible Galaxy"
ansible-galaxy install geerlingguy.packer-debian
ansible-galaxy install geerlingguy.nfs
