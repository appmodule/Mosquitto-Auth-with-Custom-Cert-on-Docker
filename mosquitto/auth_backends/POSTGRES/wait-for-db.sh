#!/bin/bash
# wait-for-postgres.sh

set -e
export PGPASSWORD=test123
#host="$1"
#shift
cmd="$@"

until psql -h postgres -U "root"  -d mosquitto-auth -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
echo $cmd
exec $cmd

