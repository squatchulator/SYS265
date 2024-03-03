#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <username>"
	exit 1
fi

username=$1
userhome="/home/$username"

useradd -m -d $userhome -s /bin/bash $username
cd $userhome
mkdir -p $userhome/.ssh

chmod 700 $userhome/.ssh
#chmod 700 $userhome/.ssh/authorized_keys
chown -R $username:$username $userhome/.ssh
sudo ssh-keygen -t rsa
sudo ssh-copy-id miles@10.0.5.200


sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PubkeyAuthentication yes /PubkeyAuthentication yes/' /etc/ssh/sshd_config


systemctl restart sshd
echo "User $username has been created and set up with passwordless SSH"
