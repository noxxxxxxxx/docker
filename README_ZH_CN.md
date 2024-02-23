# 关于

这个仓库的初衷是为了学习通过 Docker 建立一个 LNMP 环境，利用 Docker 的跨平台性，在不同操作系统下可以快速还原相同的开发、生产环境，目前已经支持很多容器，如果有其他需要欢迎提 PR 或 issue。

本仓库下所有容器配置均参照官方文档编写，用户可按照实际需求改写配置，没有定制化的脚本，因而也可以当作 Demo 进行参考学习。

已支持的容器：

- Nginx ✅
- MySql ✅
- MariaDB ✅
- PHP-FPM ✅
- Gitea ✅
- Jenkins ✅
- Redis ✅

通过 Docker 容器快速创建 LNMP 环境。

## 使用步骤

1. Linux 系统在 home 目录下 `git clone` 该仓库
2. MacOS 系统由于 Home 目录 Apple 默认不希望用户去使用、创建文件，因此可以选择在 Document 目录下 `git clone` 该仓库并使用 `macos` 分支
3. 绝大多数容器会有 `.env` 文件，需要填写配置（如 Mysql、MariaDB 容器需要填写密码），因此先确认是否填写了配置文件
4. 通常做法是进入容器对应的目录下运行 `docker compose up -d` 启动对应的容器
   1. 也可以在任意目录下运行 `docker compose` 命令，但是需要指定 `docker-compose.yml` 文件的路径，像这样：`docker-compose -f /path/to/docker-compose.yml up`
   2. 对于不太熟悉 `docker` 的同学，建议先执行 `docker compose up`，观察命令行输出没有报错信息后，再执行 `docker compose up -d`

## 环境配置

确保已经安装以下环境

### Docker 安装地址

Mac 上推荐安装 `Docker Desktop`，就无需再安装 docker compose。

`https://docs.docker.com/engine/install/ubuntu/`

### Docker Compose 安装地址

安装了 `Docker Desktop` 的可以忽略，默认自带了。

`https://docs.docker.com/compose/install/`

### 创建网络

**为了保证容器之间能够互通，请务必先执行网络创建**

bridge 网络用于 Nginx 和 Mysql php-fpm 相互联通，如果其他容器有互通需求，可以参照上述容器的 `docker-compose.yml` 文件进行修改。

`docker network create -d bridge nginx_proxy`

### LetsEncrypt 证书安装管理

本地开发、或者不需要 `https` 可以忽略。

#### 使用 acme.sh 安装管理 letsencrypt https 证书

1. 设置 DNS 方式验证证书： https://github.com/Neilpang/acme.sh/wiki/dnsapi

2. 选择 DNSPOD 的方式

   添加 DNSPOD 上获取的配置

```bash
export DP_Id=""
export DP_Key=""
```

3. 添加新域名

```bash
acme.sh --issue --dns dns_dp -d demo.domain.com
```

## phpMyAdmin 使用

1. https://www.phpmyadmin.net/ 上下载最新版的压缩包解压到 `nginx/html/default/[folder_name]` 下(**公司服务器里不要使用 phpMyAdmin，该软件若出现漏洞，不及时跟进，容易造成入侵**)
2. 启动 Nginx 容器后访问服务器 `http://ip/[folder_name]`
3. 在解压后的 `[folder_name]` 目录下找到 `config.inc.sample.php` 重命名为 `config.inc.php` 并添加 `$cfg['AllowArbitraryServer']=true;` 来开启指定 MySql 服务器地址的方式。
4. 服务器地址为 MySql 容器的名称，默认为 `mysql`，可在 `mysql/.env` 里修改 MySQL 用户名和密码

## WordPress 使用

1. wp-config.php 中 MySQL 主机填写 MySQL/MariaDB 容器名即可

2. Nginx 配置 PHP

```nginx
server {
    set $custom_path "/var/www/html/${folder_name in nginx/html}";
    listen 80;
}
```

## PHP Composer 使用

进入容器，执行 composer 命令

```bash
docker exec -it docker-php /bin/bash

cd target/directory

composer install
```

## MySQL/MariaDB 容器使用

1. MySql/MariaDB 容器启动前需要添加 root 密码， 默认使用 root 用户，可以自行修改
2. 若要支持远程链接
   - 使用前需要取消 `nginx.conf` 中相关的注释
3. 数据库容器文件夹下有 `backup.sh` 脚本，用于执行数据库导出命令，可以根据具体配置改写后执行。
4. MySql 容器使用了 5.5 的镜像版本，如果需要其他版本，可以自行调整 `docker-compose.yml` 配置文件

## Gitea 使用

GitLab 的替代品，使用 Go 编写，占用内容少，如果想使用单独的 Mysql/MariaDB 容器可以参照官方的 docker-compose.yml 配置文件

## Jenkins 容器

```bash
# 设置权限，否则无法运行
chown -R 1000:1000 /home/docker/jenkins/jenkins-data

docker-compose up -d
```

## Redis 容器

1. 数据持久映射在 `./data` 目录中
2. Redis 配置文件为 `redis.conf`
3. 目录底下直接启动容器即可

```bash
docker compose up -d
```

## Docker 常用命令

```bash
# 查看当前运行的容器列表
docker ps
# 查看本机下所有的容器列表（包含运行和停止的容器）
docker ps -a
# 删除一个容器（需要先停止这个容器）
docker rm [docker_id]
# 停止一个容器
docker stop [docker_id]
# 查看镜像
docker images
# 删除一个镜像
docker rmi [image_id]
#docker compose 重新创建新容器并后台执行
docker compose up -d --force-recreate
# 删除无名容器
docker rmi $(docker images -f "dangling=true" -q)
```

## LICENSE

[GNU](http://www.gnu.org/licenses/gpl-3.0.html)
