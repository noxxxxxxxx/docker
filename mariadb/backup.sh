#! /bin/bash

docker exec -i [mariadb_container_name] bash <<'EOF'

mysqldump -u[user_name] -p[your_password] database_name > /backup/[database_name_]$(date +%Y%m%d_%H%M%S).sql

exit

EOF

# crontab command
# 0 01 * * * /path/to/repository/mariadb/backup.sh > /dev/null 2>&1
