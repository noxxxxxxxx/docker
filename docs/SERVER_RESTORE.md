# 服务器恢复说明

本仓库只保存可公开的 Compose 定义。运行数据、证书、服务配置与凭据必须保存在仓库之外，并通过加密备份恢复。

恢复时在服务器私有环境中设置以下变量：

```bash
export REPO_ROOT=/path/to/repository
export DATA_ROOT=/path/to/private-data
```

`DATA_ROOT` 应包含 `runtime`、`config`、`secrets`、`certificates` 和 `backups` 子目录。先恢复并校验加密备份，再按依赖顺序启动数据库、缓存、应用服务与反向代理：

```bash
./scripts/server-compose mariadb up -d
./scripts/server-compose redis up -d
./scripts/server-compose gitea up -d
./scripts/server-compose sonarqube up -d
./scripts/server-compose verdoccio up -d
./scripts/server-compose php_fpm up -d
./scripts/server-compose nginx up -d
```

不要提交实际路径、主机地址、证书、`.env`、数据库数据、上传文件或备份归档。
