# About this Repo

通过 Docker 容器快速创建 LNMP 环境。

## 使用步骤

1. Linux 系统在 home 目录下 `git clone` 该仓库
2. MacOs 系统由于 Home 目录 Apple 默认不希望用户去使用创建文件，应此在 Document 目录下 `git clone` 该仓库使用 `macos` 分支
3. Mysql 容器需要配置密码
4. 进入相应的目录使用 `docker-compose -d up` 启动对应的容器
5. 先启动 php_fpm、MySQL 容器再启动 Nginx

## Docker 安装地址

`https://docs.docker.com/install/linux/docker-ce/ubuntu/`

## Docker Compose 安装地址

`https://docs.docker.com/compose/install/`

## 创建网络

bridge 网络用于 Nginx 和 Mysql php-fpm 相互联通

`docker network create -d bridge nginx_proxy`

## LetsEncrypt 证书安装管理

### 使用 acme.sh 安装管理 letsencrypt https 证书

1. 设置 DNS 方式验证证书： https://github.com/Neilpang/acme.sh/wiki/dnsapi

2. 选择 DNSPOD 的方式

   添加 DNSPOD 上获取的配置

```bash
export DP_Id=""
export DP_Key=""
```

3. 添加新域名

```bash
acme.sh --issue --dns dns_dp -d assets.noxxxx.com
```

## phpMyAdmin 使用

1. https://www.phpmyadmin.net/ 上下载最新版的压缩包解压到 `nginx/html/default/phpmyadmin` 下
2. 启动 Nginx 容器后访问服务器 `http://ip/phpmyadmin`
3. 在解压后的 `phpmyadmin` 目录下找到 `config.inc.sample.php` 重命名为 `config.inc.php` 并添加 `$cfg['AllowArbitraryServer']=true;` 开启指定 mysql 服务器地址的方式。
4. 服务器地址为 mysql 容器的名称，默认为 `global_mysql`，可在 `mysql/docker-compose.yml` 里修改 MySQL 用户名和密码

## WordPress 使用

1. wp-config.php 中 MySQL 主机填写 MySQL 容器名即可

## PHP

```nginx
server {
    set $custom_path "/var/www/html/${folder name in nginx/html}";
    listen 80;
}
```

## PHP Composer

进入容器，执行 composer 命令

```bash
docker exec -it docker-php /bin/bash

cd target/directory

composer install
```

## MySQL 容器

1. MySQL 容器启动前需要添加 root 密码， 默认使用 root 用户，可以自行修改
2. 支持远程链接
    - 使用前需要取消 `nginx.conf` 中的注释

## Gitea

GitLab 的替代品，占用内容少，如果想使用单独的 mysql 容器可以参照官方的 docker-compose.yml 配置文件

## Jenkins 容器

```bash
# 设置权限，否则无法运行
chown -R 1000:1000 /home/docker/jenkins/jenkins-data

docker-compose up -d
```

## Docker 常用命令

docker-compose 创建新容器并后台执行

```bash
docker-compose up -d --force-recreate
```

删除无名容器

```bash
docker rmi $(docker images -f "dangling=true" -q)
```

创建 sshkey 用于拉取自己的 github 仓库

```bash
ssh-keygen -t rsa -C "your-server"
```

## Donation

<img width="150" src="http://img.noxxxx.com/alipay.png" alt="donation">

## LICENSE

[GNU](http://www.gnu.org/licenses/gpl-3.0.html)
