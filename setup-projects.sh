#!/bin/bash

# debug mode : set -x
SM_CONF_DIR=/root/.symfony-manager

source ~/.bash-profile.d/bash-profile

# Copy ssh keys if there are presents
if [ -d "/root/ssh-keys" -a "$(ls /root/ssh-keys)" ]; then
	mkdir -p /root/.ssh
	cp /root/ssh-keys/* /root/.ssh
fi

for file in `find $SM_CONF_DIR/sm-config/ -type f -printf "%f\n" | egrep "^sm-config"`
do
	source $SM_CONF_DIR/sm-config/$file
	cat /root/docker-config/default-symfony-nginx.conf | sed "s/__project_name__/$application_projectname/g;s#__project_path__#$application_install_path#g;s/__project_hosts__/$application_host/g"  > /etc/nginx/sites-available/project_$application_projectname.conf
	ln -s /etc/nginx/sites-available/project_$application_projectname.conf /etc/nginx/sites-enabled/project_$application_projectname.conf
	project_name=${file/sm-config-}
#	$SM_CONF_DIR/symfony_manager.sh -l $SM_CONF_DIR/sm-config/$file -fi
	mkdir -p $application_install_path
	(
	cd $application_install_path
	#git clone $application_scmurl
	$SM_CONF_DIR/symfony_manager.sh -l $SM_CONF_DIR/sm-config/$file -fi
	)
done
