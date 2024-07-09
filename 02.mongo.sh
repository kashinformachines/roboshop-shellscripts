echo "creating/copying mongo.repo file #####################################################"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo "installing mogodb#####################################################################"
dnf install mongodb-org -y

echo "Start & Enable MongoDB Service########################################################"
systemctl enable mongod
systemctl start mongod

echo "Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf###################"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo "Restart the service to make the changes effected.#####################################"
systemctl restart mongod