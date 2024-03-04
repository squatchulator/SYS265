#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <username>"
	exit 1
fi

username=$1
userhome="/home/$username"
keypath="/home/miles/SYS265/linux/public-keys/id_rsa.pub"

sudo useradd -m -d $userhome -s /bin/bash $username
sudo mkdir -p $userhome/.ssh
sudo cat $keypath | sudo tee -a $userhome/.ssh/authorized_keys

sudo chmod 700 $userhome/.ssh
sudo chmod 600 $userhome/.ssh/authorized_keys

sudo chown -R $username:$username $userhome/.ssh



sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PubkeyAuthentication yes /PubkeyAuthentication yes/' /etc/ssh/sshd_config


sudo systemctl restart sshd
echo "User $username has been created and set up with passwordless SSH"
