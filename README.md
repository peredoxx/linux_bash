# linux_bash

Select the script you want to download and go to raw.

Example:
wget https://raw.githubusercontent.com/peredoxx/linux_bash/main/docker_install.sh

After downloading the script that has to be made executable.

Example:
sudo chmod +x docker_install.sh

If there are any problems when running try:

Example:
sed -i -e 's/\r$//' docker_install.sh
./docker_install.sh
