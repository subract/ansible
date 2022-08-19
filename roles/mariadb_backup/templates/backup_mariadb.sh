#!/bin/bash

url=https://hc-ping.com/{{ healthcheck_id_mariadb }}

# Kick the healthchecks.io monitor
curl -fsS --retry 3 $url/start > /dev/null

# Activate Nextcloud maintenance mode
docker exec nextcloud sudo -u abc php /config/www/nextcloud/occ maintenance:mode --on &&

# Back up all databases
# Overwrite existing file, because zfs will keep local versions, and Backblaze will keep versions for 30 days
docker exec mariadb sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' | gzip > /ssd/app/mariadb/dumps/mariadb.sql.gz &&

# Disable Nextcloud maintenance mode
docker exec nextcloud sudo -u abc php /config/www/nextcloud/occ maintenance:mode --off

# Explicitly fail if any command failed
if [[ $? -ne 0 ]] ; then
  echo At least one item failed.
  url=$url/fail
fi

# Confirm the finish with healthchecks.io
curl -fsS --retry 3 $url > /dev/null


