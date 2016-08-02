FROM houseofagile/docker-nginx-php-fpm:php7

MAINTAINER Meillaud Jean-Christophe (jc@houseofagile.com)

#Node install
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update \
 && apt-get install -y nodejs \
 && npm install less -g && npm install -g bower \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ \
 && mv /usr/bin/composer.phar /usr/bin/composer \
 && mkdir /root/projects && mkdir /root/ssh-keys \
 && echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config \
 && apt-get clean && rm -rf /tmp/* /var/tmp/*

ADD ./config/projects /root/projects
ADD ./config/ssh-keys /root/ssh-keys

ADD ./config/sm-config /root/.symfony-manager/sm-config
ADD .bowerrc /root/.bowerrc

RUN chown www-data -R /usr/share/nginx/ && \
mkdir -p /root/docker-config && \
rm /etc/nginx/sites-enabled/default && \
mkdir -p /etc/my_init.d
ADD ./default-symfony-nginx.conf /root/docker-config/default-symfony-nginx.conf

ADD setup-projects.sh /etc/my_init.d/10_setup-projects.sh

EXPOSE 80
CMD ["/sbin/my_init"]
