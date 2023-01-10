# ras

openresty with auto ssl in docker

![GitHub Actions](https://github.com/AmmRage/ras/workflows/CI/badge.svg)

## Docker

[![Docker Pulls](https://img.shields.io/docker/pulls/ammrage/ras.svg)](https://hub.docker.com/r/ammrage/ras)
[![Docker Stars](https://img.shields.io/docker/stars/ammrage/ras.svg)](https://hub.docker.com/r/ammrage/ras)
[![Docker Automated](https://img.shields.io/docker/cloud/automated/ammrage/ras.svg)](https://hub.docker.com/r/ammrage/ras)

## Usage

### Prepare

assume your home directory is **/home/ubuntu**, create directories for amounting volumes

* **/home/ubuntu/resty/conf.d**  --for config file of each domain

* **/home/ubuntu/resty/logs**  --for logs

* **/home/ubuntu/resty/ssl**  --for ssl certs

* **/home/ubuntu/resty/nginx.conf**  --root config file

assume your domain is **your-domain.com**, IP address of your host is **172.17.0.1**, your application listening part **8080**.

> **TAKE NOTE** above would be in usage for demonstrating purpose in config files and commands.

with those assumption, the configuration files are available in './volume_files' and './volume_files/conf.d' for your reference. please modify it accordingly in your environment.

### Run

command to start the docker container.

```
sudo docker run -it -d \
    --name ras \
    -v /home/ubuntu/resty:/usr/local/openresty/nginx/conf \
    -v /home/ubuntu/resty/logs:/usr/local/openresty/nginx/logs \
    -v /home/ubuntu/resty/ssl:/etc/ssl/mine \
    -p 80:80 \
    -p 443:443 \
    ammrage/ras:latest /bin/bash
```

get bash interactive with the container instance.

```
sudo docker exec -it ras /bin/bash
```

create 'dummy' cert for starting the nginx. before we get it from **let's encrypt**, it need a cert to meet the settings in configuration.

```
openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
-subj '/CN=sni-support-required-for-valid-ssl' \
-keyout /etc/ssl/mine/your-domain.key \
-out /etc/ssl/mine/your-domain.crt
```

start nginx

```
/usr/local/openresty/nginx/sbin/nginx
```

check the running status of nginx by using **TOP** command. if everything went well, the site has started correctly. try access your website by the domain specified, first time loading would be quite slow because it's doing the ssl auto settings.

### Add New Domain

2. **IN SERVER** add new server item in configuration file

1. **IN CONTAINER** run the command to create dummy cert

3. **IN CONTAINER** reload config. make sure be aware of the nginx reload command. 

> investigate auto reload of configuration file and other automatic things like integrate CSP api to auto add domain & add configuration items & create dummy cert 

### Notice

1. mount **/usr/local/openresty/nginx/conf**, **/usr/local/openresty/nginx/logs** and **/etc/ssl/mine** 

> **DO NOT** mount the /etc/ssl because it will affect the openssl environment.

2. for different cloud service providers, initial state of firewall may be quite different

> remember to check all firewall (iptable, ufw etc) settings before issue ssl cert.

## Build

just build it


