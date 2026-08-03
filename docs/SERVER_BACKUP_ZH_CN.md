# 服务器备份说明

[English](SERVER_BACKUP.md)

使用 `scripts/server-backup` 对公开仓库和私有数据目录执行一致性加密备份。它会
仅停止配置中会写入数据目录的容器，生成 gzip tar 数据流，在落盘前使用 GPG 加密，
本地校验加密归档后上传七牛，并在远端对象大小一致后才恢复容器。

## 私有配置

将 `scripts/server-backup.env.example` 复制到仓库之外的私有位置，替换全部占位值，
并限制配置文件和 GPG 口令文件权限：

```bash
chmod 600 /path/to/private-backup.env
chmod 600 /path/to/gpg-passphrase
```

私有配置中保存仓库根目录、私有数据根目录、七牛客户端与 Bucket、口令文件，以及
所有会写入数据目录的容器列表；它绝不能提交到 Git。

## 执行与定时任务

配置完成后先手动执行一次：

```bash
BACKUP_CONFIG_FILE=/path/to/private-backup.env ./scripts/server-backup
```

确认手动执行成功后，再由服务器定时任务执行相同命令。每次会上传两个对象：加密的
`.tar.gz.gpg` 归档和对应的 `.sha256` 校验文件。脚本不会自动删除远端备份；请在七牛
Bucket 中配置经过复核的生命周期策略管理保留时间。

## 恢复

下载归档和校验文件，先核验 SHA-256，再解密并检查归档内容，最后按
[服务器恢复说明](SERVER_RESTORE_ZH_CN.md) 的顺序启动服务。GPG 口令与备份配置
应存放在独立的凭据系统中；遗失口令将无法恢复备份。
