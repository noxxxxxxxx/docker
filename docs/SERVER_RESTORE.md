# 服务器恢复指南

本仓库只保存可公开的部署定义。服务器运行数据、密钥、私有 Nginx 配置和证书放在 `/home/data`，并由加密备份保存到七牛。

## 目录约定

```text
/home/docker/                 # 此 Git 仓库
/home/data/runtime/           # 数据库、应用数据和用户文件
/home/data/config/            # 私有 Nginx/服务配置
/home/data/secrets/           # 实际 .env、七牛与通知凭据（权限 0600）
/home/data/certificates/      # acme.sh 证书目录
/home/data/backups/           # 本地备份暂存和日志
```

`/root/.acme.sh` 在迁移后应是指向 `/home/data/certificates/acme.sh` 的符号链接；这样现有 acme.sh 定时续期命令仍可使用原路径，Nginx 也继续读取同一份证书。

## 恢复顺序

1. 安装 Docker Engine 和 Docker Compose，创建外部网络 `nginx_proxy`。
2. 克隆仓库到 `/home/docker`，检出备份清单记录的 `source_commit`。
3. 从七牛下载对应的加密归档，校验 SHA-256 后解密并恢复 `/home/data`。
4. 确认 `/root/.acme.sh -> /home/data/certificates/acme.sh`，权限保持为 root 可读。
5. 按服务加载其 `/home/data/secrets/<service>.env` 和服务器侧 Compose override，依次启动 MariaDB、Redis、Gitea、Sonar、Verdaccio、PHP-FPM、Nginx。
6. 执行 `docker compose ps`、访问 HTTPS 站点，并检查证书有效期和数据库连接。

不要把 `/home/data/secrets`、`/home/data/runtime` 或证书提交到 Git。数据库优先使用备份中的逻辑 dump 恢复；文件系统归档用于恢复应用数据、配置和应急回滚。
