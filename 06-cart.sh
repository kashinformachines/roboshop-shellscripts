echo "Install NodeJS, By default NodeJS 16 is available, We would like to enable 20 version and install list."
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

cp cart.service /etc/systemd/system/cart.service

echo "Install NodeJS"
dnf install nodejs -y

exho "Add application User"
useradd roboshop

echo "remove previous data so that it would not ask for confirmation to remove the data"
rm -rf /app

echo "setup an app directory."
mkdir /app

echo "Download the application code to created app directory."
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip

echo "download the dependencies"
cd /app
npm install

echo "Load the service."
systemctl daemon-reload

echo "Start the service."
systemctl enable cart
systemctl start cart
