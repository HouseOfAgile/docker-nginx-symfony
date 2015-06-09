export DOCKER_DB_INSTANCE=$(sudo docker ps | grep "beaudev/mysql" | nawk '{print $1}')
export DB_PASS=$(sudo docker logs $DOCKER_DB_INSTANCE | grep "mysql -uadmin" | nawk '{print $3}' | sed 's/^-p//')
export DB_HOST=`sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $DOCKER_DB_INSTANCE`
echo "Docker Mysql Instance:$DOCKER_DB_INSTANCE" 
echo -e "Docker Mysql Details:\n\thost : $DB_HOST\n\tadmin pass:$DB_PASS" 
