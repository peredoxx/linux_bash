#!/bin/bash

echo Registered user: $USER
echo Do you want to install Portainer?
read -p "Continue (y/n)?" choice
case "$choice" in
  y|Y )
  
  #Screate the volume
  
  sudo docker volume create portainer_data
  
  #Download and install the Portainer server container
  
  docker run -d -p 80:8000 -p 443:9443 --name portainer-int --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
  
  ;;
  
  n|N ) echo "Installation aborted";;
  * ) echo "invalid";;
esac