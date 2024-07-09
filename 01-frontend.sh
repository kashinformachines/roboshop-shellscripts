echo "Install Nginx##################################################################################"

dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y

echo "copying nginx configuration file##################################################################################"
cp nginx.conf /etc/nginx/nginx.conf

echo "Removing the default content in html folder##################################################################################"

rm -rf /usr/share/nginx/html/*

echo "Downloading project content##################################################################################"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

echo "changing to the html directory##################################################################################"
cd /usr/share/nginx/html

echo "unzipping the downloaded content here##################################################################################"
unzip /tmp/frontend.zip

echo "enabling the service##################################################################################"
systemctl enable nginx
echo "starting/restarting the webserver##################################################################################"
systemctl restart nginx