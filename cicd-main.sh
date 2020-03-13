#!/bin/bash
# cicd-server.sh: CICD process for webapp app services

# source stage
# git clone from github

set -exf -o pipefail

DBPASSWORD="passw0rd"

# database install

PACKAGE=mariadb
DEPLOYED=$(helm list |grep -E "^${PACKAGE}" |grep DEPLOYED |wc -l)
if [ $DEPLOYED == 0 ] ; then
  echo "Install $PACKAGE"
  REPO="https://kubernetes-charts.storage.googleapis.com"
  helm repo add stable $REPO
  helm install --namespace webappdb --wait --set mariadb.db.password=${DBPASSWORD} -f ${PACKAGE}/override.yaml --name ${PACKAGE} stable/mariadb
fi

# server install
echo "Install server"
sh ./server/cicd-server.sh $DBPASSWORD

#client install
echo "Install client"
sh ./client/cicd-client.sh 
