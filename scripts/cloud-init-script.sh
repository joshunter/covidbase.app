#!/bin/bash


# Using Ubuntu 18.04


# Install dependancies
sudo apt update && sudo apt upgrade -y
sudo apt install npm -y
sudo apt install mongodb -y
sudo npm install mongodb
sudo npm install express
sudo npm install cors

# Pull files
(echo "\n"; echo "\n") | gcloud compute scp --recurse --zone="us-east4-c" world-db-instance:~/db-files ~/db-files

# db-files: server scripts
# server: routes index.js
# scripts: init-db-script scrape-script cronjobs

# Add cronjob for scrape-script
crontab ~/db-files/scripts/cronjobs

# scrape site and initiate database
bash ~/db-files/scripts/init-db-script.sh

# -start node server
sudo node ~/db-files/server/index.js
