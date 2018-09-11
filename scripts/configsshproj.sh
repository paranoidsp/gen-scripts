#!/bin/bash

set -e
set -x

if [ -z $1 ] ; then
  echo "Usage: $0 $KUBECTL_CONTEXT"
  exit 1
fi
project=$1
token=$HASURA_PROD_TOKEN
query=$(echo '{"type": "select", "args": {"columns": ["ssh_keys"], "table": "prod_project", "where": {"name" : ""}}}' | jq -c -r ".args.where.name = \"$project\"")
echo $query

# decodedTkn=$(curl -s -X POST --header "Content-Type:application/json" --header "Authorization: Bearer $2" -d $query https://data.beta.hasura.io/v1/query | jq -r '.[0].ssh_keys' | base64 --decode | jq -r '.private')

keys=$(curl -s -X POST --header "Content-Type:application/json" --header "Authorization: Bearer $HASURA_PROD_TOKEN" -d $query https://data.hasura.io/v1/query )
echo $keys | jq -r '.[0].ssh_keys' | base64 -d | jq -r '.private' > ~/projssh/$project.private.pem
chmod 600 ~/projssh/$project.private.pem

CONFIG_FILE="$HOME/.ssh/projects"

echo "" >> $CONFIG_FILE
echo "Host $project" >> $CONFIG_FILE
echo "    Hostname $project.hasura-app.io" >> $CONFIG_FILE
echo "    Port 2022" >> $CONFIG_FILE
echo "    user core" >> $CONFIG_FILE
echo "    IdentityFile ~/projssh/$project.private.pem" >> $CONFIG_FILE
