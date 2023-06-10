#! /bin/bash

docker exec -i [mariadb_container_name] bash <<'EOF'

mysqldump -u[user_name] -p[your_password] database_name > /home/data/[database_name_]$(date +%Y%m%d_%H%M%S).sql

exit

EOF

# crontab command
# 0 01 * * * /home/docker/mariadb/backup.sh > /dev/null 2>&1
