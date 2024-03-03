#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <username>"
	exit 1
fi

username=$1
userhome="/home/$username"

sudo useradd -m -d $userhome -s /bin/bash $username
sudo mkdir -p $userhome/.ssh
sudo chmod 700 $userhome/.ssh
sudo chown -R $username:$username $userhome/.ssh

sudo -u $username ssh-keygen -t rsa -f $userhome/.ssh/id_rsa -N ""
sudo -u $username ssh-copy-id miles@10.0.5.200

sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PubkeyAuthentication yes /PubkeyAuthentication yes/' /etc/ssh/sshd_config


systemctl restart sshd
echo "User $username has been created and set up with passwordless SSH"
