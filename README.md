# About this Repo

You can use this repo to build your LNMP quickly by using docker.

## Support

- [x] Laravel
- [x] Wordpress

## Usage

### Linux

```bash
git clone https://github.com/noxxxxxxxx/docker.git
```

### Mac

```bash
git clone https://github.com/noxxxxxxxx/docker.git

# use macos branch, normally the system not recommend to modify home directory, so we choose document directory
git checkout macos
```

## Prepare

You need install these tools before you start to use.

- Docker
- docker compose

## Network

Use bridge network to connect container

```bash
docker network create -d bridge nginx_proxy
```

## Let'sEncrypt

Install [acme.sh](https://github.com/Neilpang/acme.sh)

## phpMyAdmin

1. unzip your phpmyadmin file in `nginx/html/default/phpmyadmin`
2. setting config file

```bash
mv config.inc.sample.php config.inc.php

vim config.inc.php

# add $cfg['AllowArbitraryServer']=true;
```

3. if nginx container is running, visit `http://ip/phpmyadmin`
4. server address is mysql container name `global_mysql`，which you can modify in `mysql/docker-compose.yml`

## WordPress

1. `DB_HOST` in `wp-config.php` is mysql container name `global_mysql`

## PHP

```nginx
server {
    set $custom_path "/var/www/html/${folder name in nginx/html}";
    listen 80;
}
```

## PHP Composer

Composer install

```bash
docker exec -it docker-php /bin/bash

cd target/directory

composer install
```

## MySQL container

Before you start mysql container, you need modify mysql root password

1. Support remote connect
    - If you want to connect MySql container from remote, you can uncomment the code from `nginx.conf`

## Jenkins container

```bash
# run this command before you start jenkins container

chown -R 1000:1000 /home/docker/jenkins/jenkins-data

docker-compose up -d
```

## Donation

<img width="150" src="http://img.noxxxx.com/alipay.png" alt="donation">

## LICENSE

[GNU](http://www.gnu.org/licenses/gpl-3.0.html)
