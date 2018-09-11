#!/usr/bin/env bash
set -e

if [ -z $1 ] ; then
  echo "Usage: $0 $KUBECTL_CONTEXT aws_ip"
  exit 1
fi
project=$1
token=$HASURA_PROD_TOKEN
echo "TOKEN: $token"
query=$(echo '{"type": "select", "args": {"columns": ["id","admin_token", "provider_ip", "provider_fqdn"], "table": "prod_project", "where": {"name" : ""}}}' | jq -c -r ".args.where.name = \"$project\"")
#echo $query
query_response=$(curl -s -X POST --header "Content-Type:application/json" --header "Authorization: Bearer $token" -d $query https://data.hasura.io/v1/query)
#echo "Query response is $query_response"
project_id=$(echo $query_response | jq -r '.[0].id')
decodedTkn=$( echo $query_response | jq -r '.[0].admin_token' | base64 --decode)
provider_ip=$( echo $query_response | jq -r '.[0].provider_ip' )
provider_fqdn=$( echo $query_response | jq -r '.[0].provider_fqdn' )

query2=$(echo '{"type": "select", "args": {"columns": ["public_ip"], "table": "aws", "where": {"project_id" : ""}}}' | jq -c -r ".args.where.project_id = \"$project_id\"")

query_response2=$(curl -s -X POST --header "Content-Type:application/json" --header "Authorization: Bearer $token" -d $query https://data.hasura.io/v1/query)

provider_ip=$(echo $query_response2 | jq -r '.[0].public_ip')
subdomain=$provider_ip
# echo "Provider: ($provider_ip, $provider_fqdn, $decodedTkn)"
echo "IP: $provider_fqdn"
echo "FQDN: $provider_fqdn"

if [[ "$provider_ip" == "null" ]]
    then
        subdomain=$provider_fqdn
fi


project=$project-aws
subdomain=$2
echo "Subdomain: $subdomain"

#echo $decodedTkn
echo "Token: $decodedTkn"
kubectl config set-cluster $project --server=https://$subdomain:3443 --insecure-skip-tls-verify=true
kubectl config set-credentials $project --token=$decodedTkn
kubectl config set-context $project --cluster=$project --namespace=default --user=$project
kubectl config set-context $project-hasura --cluster=$project --namespace=hasura --user=$project
kubectl config use-context $project
export KUBECTL_CONTEXT=$project
