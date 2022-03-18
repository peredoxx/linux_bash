#!/bin/bash

echo Registered user: $USER
echo Do you want to install Docker Engine?
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) 

  #Set up the repository 

  sudo apt-get update
  sudo apt-get install ca-certificates curl gnupg lsb-release -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  #Install Docker Engine

  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io -y
  ;;
  
  n|N ) echo "Installation aborted";; 
  * ) echo "invalid";;
esac

echo Do you want to install Docker Compose?
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) 
  
  #Intsall Docker Compose

  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  ;;
  
  n|N ) echo "Installation aborted";; 
  * ) echo "invalid";;
esac

echo Add your user to the docker group?
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) 
  
  #Add your user to the docker group
  
  sudo usermod -aG docker $USER
  ;;
  
  n|N ) echo "Installation aborted";; 
  * ) echo "invalid";;
esac

