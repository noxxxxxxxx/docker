# 服务器恢复说明

本仓库只保存可公开的 Compose 定义。运行数据、证书、服务配置与凭据必须保存在仓库之外，并通过加密备份恢复。

恢复前在服务器私有环境中设置以下变量：

```bash
export REPO_ROOT=/path/to/repository
export DATA_ROOT=/path/to/private-data
```

`DATA_ROOT` 必须包含 `runtime`、`config`、`secrets`、`certificates` 和
`backups` 目录。下载与仓库版本匹配的加密备份，校验其 SHA-256 旁车文件，
解密并恢复仓库目录和数据目录，然后按依赖顺序启动服务：

```bash
./scripts/server-compose mariadb up -d
./scripts/server-compose redis up -d
./scripts/server-compose gitea up -d
./scripts/server-compose sonarqube up -d
./scripts/server-compose verdoccio up -d
./scripts/server-compose php_fpm up -d
./scripts/server-compose nginx up -d
```

不要提交实际部署路径、主机地址、证书、`.env`、数据库数据、用户上传文件或
备份归档。备份流程见[服务器备份说明](SERVER_BACKUP_ZH_CN.md)。
