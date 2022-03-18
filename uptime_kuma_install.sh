#!/bin/bash

echo Registered user: $USER
echo Do you want to install Uptime-Kuma?
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) 

  #Deploy the Portainer Agent
  
  docker volume create uptime-kuma
  
  docker run -d --restart=always -p 80:3001 -v uptime-kuma:/app/data --name uptime-int louislam/uptime-kuma:latest
  ;;
  
  n|N ) echo "Installation aborted";; 
  * ) echo "invalid";;
esac
