echo "Install redis, By default redis *** is available, We would like to enable 7 version and install list."

dnf module disable redis -y
dnf module enable redis:7 -y

echo "Install Redis"
dnf install redis -y

echo "Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf and Update protected-mode from yes to no in /etc/redis/redis.conf"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf

sed -i -e '/^bind/ s/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf

echo"Start & Enable Redis Service"
systemctl enable redis
systemctl start redis
