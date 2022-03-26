#!/bin/bash

echo Registered user: $USER
echo Do you want to install Portainer Agent?
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) 

  #Deploy the Portainer Agent 

  docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:2.9.3
  ;;
  
  n|N ) echo "Installation aborted";; 
  * ) echo "invalid";;
esac
