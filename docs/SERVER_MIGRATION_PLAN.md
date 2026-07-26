# /home/data 迁移计划

1. 生成并校验 `/home/docker` 的迁移前压缩快照。
2. 创建 `/home/data/{runtime,config,secrets,certificates,backups}`，权限仅限 root。
3. 逐服务停止、移动持久化目录、更新服务器 Compose override、再启动并健康检查。迁移对象包括 MariaDB、Redis、Gitea、Gitea runner、Sonar PostgreSQL 与 Sonar 数据、Verdaccio、QingLong、File Browser，以及 Nginx 私有站点文件和日志。
4. 将 `/root/.acme.sh` 移到 `/home/data/certificates/acme.sh`，再建立兼容符号链接，保留既有续期 cron。
5. 将真实 `.env` 移入 `/home/data/secrets`；仓库仅保留 `.env.example`。
6. 备份任务先导出数据库，再打包 `/home/data`、记录 Git commit 和 SHA-256、加密上传七牛。上传校验成功后才清理本地临时包。
7. 新服务器按 `SERVER_RESTORE.md` 演练恢复一次。
