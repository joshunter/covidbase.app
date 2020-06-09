#!/bin/bash


# Using Ubuntu 18.04


# Install dependancies
sudo apt update && sudo apt upgrade -y
sudo apt install npm -y
sudo apt install mongodb -y
sudo npm install mongodb
sudo npm install express
sudo npm install cors

sleep 5

# Pull files
(echo "\n"; echo "\n") | sudo gcloud compute scp --recurse --zone="us-east4-c" world-db-instance:~/db-files ~/

sleep 5

# db-files: server scripts
# server: routes index.js
# scripts: init-db-script scrape-script cronjobs

# scrape site and initiate database
sudo bash ~/db-files/scripts/scrape-script.sh

# Add cronjob for scrape-script
sudo crontab ~/db-files/scripts/cronjobs

# -start node server
sudo node ~/db-files/server/index.js

# Minimized:
#!/bin/bash
# sudo apt update && sudo apt upgrade -y
# sudo apt install npm -y
# sudo apt install mongodb -y
# sudo npm install mongodb
# sudo npm install express
# sudo npm install cors
# sleep 5
# (echo "\n"; sleep 1; echo "\n") | sudo gcloud compute scp --recurse --zone="us-east4-c" world-db-instance:~/db-files ~/
# sleep 5
# bash ~/db-files/scripts/scrape-script.sh
# sudo crontab ~/db-files/scripts/cronjobs
# sudo node ~/db-files/server/index.js