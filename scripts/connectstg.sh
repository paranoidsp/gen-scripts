#!/usr/bin/env bash
set -e

project=$1
token=$HASURA_STG_TOKEN
query=$(echo '{"type": "select", "args": {"columns": ["admin_token", "provider_ip", "provider_fqdn"], "table": "prod_project", "where": {"name" : ""}}}' | jq -c -r ".args.where.name = \"$project\"")
#echo $query
query_response=$(curl -s -X POST --header "Content-Type:application/json" --header "Authorization: Bearer $token" -d $query https://data.hasura-stg.hasura-app.io/v1/query)
#echo "Query response is $query_response"
decodedTkn=$( echo $query_response | jq -r '.[0].admin_token' | base64 --decode)
provider_ip=$( echo $query_response | jq -r '.[0].provider_ip' )
provider_fqdn=$( echo $query_response | jq -r '.[0].provider_fqdn' )

subdomain=$provider_ip
# echo "Provider: ($provider_ip, $provider_fqdn, $decodedTkn)"
echo "IP: $provider_fqdn"
echo "FQDN: $provider_fqdn"

if [[ "$provider_ip" == "null" ]]
    then
        subdomain=$provider_fqdn
fi

echo "Subdomain: $subdomain"

#echo $decodedTkn
kubectl config set-cluster $project --server=https://$subdomain:3443 --insecure-skip-tls-verify=true
kubectl config set-credentials $project --token=$decodedTkn
kubectl config set-context $project --cluster=$project --namespace=default --user=$project
kubectl config set-context $project-hasura --cluster=$project --namespace=hasura --user=$project
kubectl config use-context $project
export KUBECTL_CONTEXT=$project
