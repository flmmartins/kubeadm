#!/bin/bash
set -e
VBOX_INTERFACE_NAME="enp0s8"
ADDRESS="$(ip -4 addr show $VBOX_INTERFACE_NAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu-bionic entry
sed -e '/^.*ubuntu-focal.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
92.168.56.11  master-1
192.168.56.12  master-2
192.168.56.21  worker-1
192.168.56.22  worker-2
192.168.56.30  lb
EOF