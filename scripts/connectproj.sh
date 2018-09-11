#!/usr/bin/env bash
set -e


if [ -z $1 ] ; then
  echo "Usage: $0 $KUBECTL_CONTEXT [quiet]"
  exit 1
fi


project=$1
token=$HASURA_PROD_TOKEN
echo "TOKEN: $token"
query=$(echo '{"type": "select", "args": {"columns": ["admin_token", "provider_ip", "provider_fqdn"], "table": "prod_project", "where": {"name" : ""}}}' | jq -c -r ".args.where.name = \"$project\"")
#echo $query
query_response=$(curl -s -X POST --header "Content-Type:application/json" --header "Authorization: Bearer $token" -d $query https://data.hasura.io/v1/query)
#echo "Query response is $query_response"
decodedTkn=$( echo "$query_response" | jq -r '.[0].admin_token' | base64 --decode)
provider_ip=$( echo "$query_response" | jq -r '.[0].provider_ip' )
provider_fqdn=$( echo "$query_response" | jq -r '.[0].provider_fqdn' )

subdomain=$provider_ip
# echo "Provider: ($provider_ip, $provider_fqdn, $decodedTkn)"
if [ -z $2 ]
then
  echo "IP: $provider_fqdn"
  echo "FQDN: $provider_fqdn"
fi

if [[ "$provider_ip" == "null" ]]
    then
        subdomain=$provider_fqdn
fi

if [ -z $2 ]
then
  echo "Subdomain: $subdomain"

#echo $decodedTkn
  echo "Token: $decodedTkn"
fi
kubectl config set-cluster $project --server=https://$subdomain:3443 --insecure-skip-tls-verify=true
kubectl config set-credentials $project --token=$decodedTkn
kubectl config set-context $project --cluster=$project --namespace=default --user=$project
kubectl config set-context $project-hasura --cluster=$project --namespace=hasura --user=$project
kubectl config use-context $project
export KUBECTL_CONTEXT=$project
