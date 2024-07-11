echo "Setup the RabbitMQ repo file"
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo

echo "Install RabbitMQ"
dnf install rabbitmq-server -y

echo "Start RabbitMQ Service"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo "RabbitMQ comes with a default username / password as guest/guest. But this user cannot be used to connect. Hence, we need to create one user for the application."

rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
