#!/bin/bash

# Step 1: Update system packages
sudo apt update

# Step 2: Install Apache web server
sudo apt install -y apache2

# Step 3: Enable UFW firewall
sudo ufw enable

# Step 4: Allow Apache Full through firewall
sudo ufw allow 'Apache Full'

# Step 5: Allow SSH through firewall
sudo ufw allow ssh

# Step 7: Clone your GitHub repository
git clone https://github.com/menakajanith/script_test.git

# Step 8: Move the cloned repository to /var/www/test
sudo mv script_test /var/www/script_test

# Step 9: Create Apache VirtualHost configuration file
sudo bash -c 'cat > /etc/apache2/sites-available/cybetraffic.tech.conf << EOF
<VirtualHost *:80>
    ServerName www.cybetraffic.tech
    ServerAdmin contact@cybetraffic.tech
    DocumentRoot /var/www/script_test
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF'

# Step 10: Enable the new site configuration
sudo a2ensite cybetraffic.tech.conf

# Step 11: Disable the default site configuration
sudo a2dissite 000-default.conf

# Step 12: Restart Apache to apply changes
sudo service apache2 restart

# Step 13: Install Certbot and Apache plugin for SSL certificates
sudo apt install -y certbot python3-certbot-apache

# Step 14: Obtain and install SSL certificate for your domain
sudo certbot --apache --non-interactive --agree-tos --email contact@cybetraffic.tech -d www.cybetraffic.tech

echo "Setup complete! Your website is live and secured with SSL."
