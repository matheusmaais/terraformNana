#Simple script to update package manager,install and configure docker, run a nginx container on :8080
#!/bin/bash
sudo yum update -y && sudo yum install docker -y
sudo systemctl start docker
sudo usermod -aG docker ec2-user
newgrp docker 
docker run -p 8080:80 nginx