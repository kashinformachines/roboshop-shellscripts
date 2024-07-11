
echo "copying/creating catalogue.service and mongo.repo##################################################"
cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo "Install NodeJS, By default NodeJS 16 is available, We would like to enable 20 version and install list.##################################################"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

echo "installing nodejs"
dnf install nodejs -y

echo "Add application User"
useradd roboshop

echo "remove previous data so that it would not ask for confirmation to remove the data"
rm -rf /app

echo "Lets setup an app directory."
mkdir /app

echo "Download the application code to created app directory."
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip

echo "Lets download the dependencies."
cd /app
npm install
echo "Load the service."
systemctl daemon-reload
echo "Start the service."
systemctl enable catalogue
systemctl start catalogue

echo "To load schema / master data we need to install mongodb client and then we can load it.

      To have mongo client installed we have to setup MongoDB repo and install mongodb-client"
dnf install mongodb-mongosh -y
echo "Load Master Data of the List of products we want to sell and their quantity information also there in the same master data."
mongosh --host mongo.dev.kashdevopspractice.online </app/db/master-data.js

