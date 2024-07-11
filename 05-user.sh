echo "Setup SystemD User Service"
cp user.service /etc/systemd/system/user.service

echo "Install NodeJS, By default NodeJS 16 is available, We would like to enable 20 version and install list."
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

echo "Install NodeJS"
dnf install nodejs -y

echo "Add application User"
useradd roboshop

echo "remove previous data so that it would not ask for confirmation to remove the data"
rm -rf /app

echo "setup an app directory."
mkdir /app

echo "Download the application code to created app directory."
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip

echo "download the dependencies."
cd /app
npm install

echo "Load the service."
systemctl daemon-reload

echo "Start the service."
systemctl enable user
systemctl start user

