FROM HouseOfAgile/docker-nginx-php-fpm:latest

MAINTAINER Meillaud Jean-Christophe (jc.meillaud@gmail.com)

#Node install
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update

RUN apt-get install -y nodejs
RUN npm install less -g
RUN npm install -g bower

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/
RUN mv /usr/bin/composer.phar /usr/bin/composer

ADD ./config/projects /usr/share/nginx/
RUN chown www-data -R /usr/share/nginx/

## Install SSH for a specific user (thanks to public key)
ADD ./private/id_rsa.pub /tmp/your_key
RUN cat /tmp/your_key >> /root/.ssh/authorized_keys && rm -f /tmp/your_key

# Add private key in order to get access to private repo
ADD ./private/id_rsa /root/.ssh/id_rsa

RUN apt-get clean && rm -rf /tmp/* /var/tmp/*

ADD ./config/sm-config /root/.symfony-manager/sm-config

RUN mkdir -p /etc/my_init.d
ADD setup-projects.sh /etc/my_init.d/setup-projects.sh

EXPOSE 80

CMD ["/sbin/my_init"]
