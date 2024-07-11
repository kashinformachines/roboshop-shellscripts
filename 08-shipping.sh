echo "copying service file"
cp shipping.service /etc/systemd/system/shipping.service

echo "Shipping service is written in Java, Hence we need to install Java.

      Maven is a Java Packaging software, Hence we are going to install maven, This indeed takes care of java installation."

dnf install maven -y

echo "Add application user"
useradd roboshop

echo "remove previous data so that it would not ask for confirmation to remove the data"
rm -rf /app

echo "setup an app directory."
mkdir /app

echo "Download the application code to created app directory."
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip

echo "download the dependencies & build the application"
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo "We need to load the schema. To load schema we need to install mysql client.

      To have it installed we can use"

dnf install mysql -y

echo "Load Schema, Schema in database is the structure to it like what tables to be created and their necessary application layouts."

mysql -h mysql.dev.kashdevopspractice.online -uroot -pRoboShop@1 < /app/db/schema.sql

echo "Load Master Data, This includes the data of all the countries and their cities with distance to those cities."

mysql -h mysql.dev.kashdevopspractice.online -uroot -pRoboShop@1 < /app/db/master-data.sql

echo "Create app user, MySQL expects a password authentication, Hence we need to create the user in mysql database for shipping app to connect."
mysql -h mysql.dev.kashdevopspractice.online -uroot -pRoboShop@1 < /app/db/app-user.sql

echo "Load the service."
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping



