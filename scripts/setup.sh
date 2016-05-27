#!/bin/bash

perl -p -i -e 's#http://us.archive.ubuntu.com/ubuntu#http://mirror.rackspace.com/ubuntu#gi' /etc/apt/sources.list

# Update the box
apt-get -y update >/dev/null
apt-get -y install facter linux-headers-$(uname -r) build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev curl unzip >/dev/null

# Tweak sshd to prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Remove 5s grub timeout to speed up booting
cat <<EOF > /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.

GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
EOF

update-grub

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
