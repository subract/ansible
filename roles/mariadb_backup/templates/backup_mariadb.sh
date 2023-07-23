#!/bin/bash

url=https://hc-ping.com/{{ healthcheck_id_mariadb }}

# Start the healthchecks.io monitor
curl -fsS --retry 3 $url/start > /dev/null

# Ensure failures in pipelines are detected
set -o pipefail

# Activate Nextcloud maintenance mode
docker exec nextcloud occ maintenance:mode --on &&

# Back up all databases
# Overwrite existing file, because zfs will keep local versions, and Backblaze will keep versions for 30 days
docker exec mariadb sh -c 'exec mariadb-dump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' | gzip > /ssd/app/mariadb/dumps/mariadb.sql.gz

# Explicitly fail if either command failed
if [[ $? -ne 0 ]] ; then
  echo At least one item failed.
  url=$url/fail
fi

# Disable Nextcloud maintenance mode
docker exec nextcloud occ maintenance:mode --off

# Signal success or failure to Healthchecks
curl -fsS --retry 3 $url > /dev/null


