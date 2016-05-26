# docker-nginx-symfony

Docker + nginx + php-fpm + bash-profile + symfony manager + composer for symfony projects

This docker instance is based on docker [phusion base-image](https://github.com/phusion/baseimage-docker)

## How it works
This docker image is based on bash-profile and symfony manager to deploy and install symfony projects.

##Specific configuration

There are 3 directories to stores your file:
* `./config/sm-config` : sm-config files. Need to start with `sm-config` and should contain the main variables used by symfony manager (see [symfony manager](https://github.com/jmeyo/dacorp-symfony-manager)). Name of the file is used in order to find the directory containing specific files
* `./config/projects` : put specific files related to your projects. Each files and directory path should be complete and within a directory with the name of the project specified
* `./config/ssh-keys` : put here your ssh-keys if you are using private repos.



## Recomended way to use it
Just "inherit" from this image and copy your own files in the correct directories

    FROM houseofagile/docker-nginx-symfony:latest

    ADD ./config/projects /root/projects
    ADD ./config/ssh-keys /root/ssh-keys
    ADD ./config/sm-config /root/.symfony-manager/sm-config

    EXPOSE 80
    CMD ["/sbin/my_init"]

Build your image with your project name 

    docker build -t "houseofagile/my-symfony-project:v1" .

## Use it behind [jwilder proxy](https://github.com/jwilder/nginx-proxy) and [jrcs letsencrypt companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion)

    PROJECT_NAME=your-project DOMAIN_NAMES="www.awesomedomain.com,amazingotherdomain.xyz" && docker run -e VIRTUAL_HOST="$DOMAIN_NAMES" -e LETSENCRYPT_HOST="$DOMAIN_NAMES" -e LETSENCRYPT_EMAIL="jc@houseofagile.com" -h $PROJECT_NAME --name $PROJECT_NAME -d -P houseofagile/my-symfony-project:v1



