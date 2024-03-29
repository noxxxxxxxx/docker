# About this Repo

You can use this repo to build your LNMP quickly by using docker.

For now many softwares have been uesd in docker container.

If you want to add new container, feel free to make PR .

Support：

- Nginx ✅
- Mysql ✅
- Mariadb ✅
- PHP-FPM ✅
- Gitea ✅
- Jenkins ✅
- Redis ✅

[中文文档](https://github.com/noxxxxxxxx/docker/blob/master/README_ZH_CN.md)

## LNMP Usage

### Linux

```bash
git clone https://github.com/noxxxxxxxx/docker.git
```

### Mac

```bash
git clone https://github.com/noxxxxxxxx/docker.git

# use macos branch, because normally the system not recommend to modify home directory, so we choose document directory
git checkout macos
```

## Prepare

You need install these tools before you start to create Docker container.

- Docker
- Docker Compose

## Network

Use bridge network to connect each container

```bash
docker network create -d bridge nginx_proxy
```

## Let'sEncrypt

If no need to use https, ignore this part.

Install [acme.sh](https://github.com/Neilpang/acme.sh)

## phpMyAdmin

You can connect mysql container through Nginx.

1. unzip your phpmyadmin file in `nginx/html/default/phpmyadmin`
2. setting config file

```bash
mv config.inc.sample.php config.inc.php

vim config.inc.php

# add $cfg['AllowArbitraryServer']=true;
```

3. if nginx container is running, visit `http://ip/phpmyadmin`
4. server address is mysql container name `mysql`，which you can modify in `mysql/docker-compose.yml`

## WordPress

1. `DB_HOST` in `wp-config.php` is mysql container name `mysql`

### Nginx PHP config

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

## Gitea container

Like GitLab but less memory useage. If you want to use the seperate database container, you can use the official docker-compose.yml file.

## Jenkins container

```bash
# run this command before you start jenkins container

chown -R 1000:1000 /home/docker/jenkins/jenkins-data

docker compose up -d
```

## Redis container

1. `./data` redis data
2. `redis.conf` redis config

```bash
docker compose up -d
```

## LICENSE

[GNU](http://www.gnu.org/licenses/gpl-3.0.html)
