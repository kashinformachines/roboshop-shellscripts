echo "copying service file"
cp payment.service /etc/systemd/system/payment.service

echo "Install Python 3"
dnf install python3 gcc python3-devel -y

echo "Add application User"
useradd roboshop

echo "remove previous data so that it would not ask for confirmation to remove the data"
rm -rf /app

echo "setup an app directory."
mkdir /app

echo "Download the application code to created app directory."
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app
unzip /tmp/payment.zip

echo "download the dependencies."
cd /app
pip3 install -r requirements.txt

echo "Load the service and Start the service."
systemctl daemon-reload
systemctl enable payment
systemctl restart payment

