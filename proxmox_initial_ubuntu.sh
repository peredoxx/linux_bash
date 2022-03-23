#!/bin/bash

# System Patchen
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y

# Proxmox Guest Agent Install
sudo apt-get install qemu-guest-agent -y

# Add Public SSH Key for Login
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJP0UlWs4SDL/6vXwOoiRifRURatDX3MAfeaY4AASZT32eghODk4jAcnZLyjs2O7KtsOB9qM+rOzyHCYYeqDFbUlaYr1ox5IaUBDgCEKYR/6e1n7McDcoOVVMKjNCd7D6vxOMYZzqW1TijAygMzesJuiXvE+FQAgiCOqn2jHi4qFLqcJgzUlKFrGZnbEIVdEBetLxqShcl/wkVwXsxH3kJcOMxYTxL/TH+9xGJZi/myewldgIPxXJAkEX5g+uiujuASqWbYRmBfmAXrmVbrCkzsW7z7PFyJAn8vyBrlQsoS/tZfDRXzYVw/dHxbTg5SPvu2uTjYspcZ0khfV6fdpDh0Y2aCuw7y+ldyRhIctisB6Db3OxV5lPY1FZpJJMYV/7KQBWPkuevmbsSs9Ire9hT8LBT2kfYhRn7VS7GKLhONqmL2exrV9i0+8RmygvKycqcWB3aEiVlEoOPV7kkN24CqevV686m5pyqt6EUjMQWWx6tk116VbLX2P7LzpTCb5UptlWdqPZHM3fU9V6KW1IJqFUIma4Zb7ur1gcPIctT/14WjLZgIJd5Z41Du9Fx0RDJtRY7LXBMUT1QEag47AAo+rYliQLtXcD+GKAC7wYcubbFd6q3g5wU8pD+C6CVTwP7f2FllXzwV0d7Y5VV2WoDl8G6Pj8QxBW4uR+LU/5cZQ== philipp.pauli@fastinbox.de >> ~/.ssh/authorized_keys

# Enable automatic patches 
sudo apt install unattended-upgrades apt-listchanges -y
sudo dpkg-reconfigure -plow unattended-upgrades

# Modifying /etc/ssh/sshd_conf
if [[ "${UID}" -ne 0 ]]; then
    echo " You need to run this script as root"
    exit 1
fi

# To directly modify sshd_config.

sed -i 's/#\?\(Port\s*\).*$/\1 22/' /etc/ssh/sshd_config
sed -i 's/#\?\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config
sed -i 's/#\?\(PubkeyAuthentication\s*\).*$/\1 yes/' /etc/ssh/sshd_config
sed -i 's/#\?\(PermitEmptyPasswords\s*\).*$/\1 no/' /etc/ssh/sshd_config
sed -i 's/#\?\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config

# Check the exit status of the last command

if [[ "${?}" -ne 0 ]]; then
   echo "The sshd_config file was not modified successfully"
   exit 1
fi
/etc/init.d/ssh restart

exit 0
