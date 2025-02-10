# About this Repo

You can use this repository to quickly build your `LNMP` stack using Docker.

Currently, many software applications are being utilized within Docker containers.

All container configurations in this repository are written in accordance with the official documentation. Users can modify the configurations according to their actual needs. There are no customized scripts, so they can also be used as demos for reference and learning.

If you want to add new container, feel free to make PR.

Support：

- Nginx ✅
- Mysql ✅
- Mariadb ✅
- PHP-FPM ✅
- Gitea ✅
- Jenkins ✅
- Redis ✅
- Glances ✅

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
2. Config your site.conf

```nginx
server {
    set $custom_path "/var/www/html/${folder_name in nginx/html}";
    listen 80;
}
```

3. `chown -R www-data:www-data /home/docker/nginx/html/your_wordpress_site_file`

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

## Glances

1. Update `glances.conf` file before you get ready to use the latest version of Glances
2. Use `docker compose build`，so you can customize the configuration
3. `docker compose up -d`
4. Open your browser and visit ip::61208

## LICENSE

[GNU](http://www.gnu.org/licenses/gpl-3.0.html)
