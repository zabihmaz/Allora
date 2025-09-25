
#!/bin/bash

# Update packages and install jq
sudo apt-get update && sudo apt-get -y install jq

# Check if Docker is installed
if command -v docker &> /dev/null
then
    echo "Docker is already installed."
else
    echo "Docker is not installed. Installing Docker now..."

    # Install prerequisites
    sudo apt-get update &&
    sudo apt-get -y install ca-certificates curl gnupg &&
    sudo install -m 0755 -d /etc/apt/keyrings &&
    
    # Add Docker GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg &&
    sudo chmod a+r /etc/apt/keyrings/docker.gpg &&
    
    # Add Docker repository
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &&
    
    # Install Docker
    sudo apt-get update &&
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &&
    sudo apt-get -y install docker-compose &&
    
    # Add current user to docker group
    sudo usermod -aG docker $USER
    newgrp docker

    echo "Docker installation completed successfully!"
fi
