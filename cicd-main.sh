#!/bin/bash
# cicd-server.sh: CICD process for webapp app services

# source stage
# git clone from github

set -exf 

# in production, the credentials can get from vault or secret management from CI tool
DB_PASSWORD="passw0rd"

# database install

PACKAGE=mariadb
DB_NAMESPACE=webappdb
DEPLOYED=$(helm list |grep -E "^${PACKAGE}" |grep DEPLOYED |wc -l)
if [ $DEPLOYED -eq 0 ] ; then
  echo "Install $PACKAGE"
  REPO="https://kubernetes-charts.storage.googleapis.com"
  helm repo add stable $REPO
  helm install --namespace $DB_NAMESPACE --wait --set mariadb.db.password=${DB_PASSWORD} -f ${PACKAGE}/override.yaml --name ${PACKAGE} stable/mariadb
fi

# server install
echo "Install server"
(cd server && sh ./cicd-server.sh "${PACKAGE}.$DB_NAMESPACE" $DB_PASSWORD )

#client install
echo "Install client"
(cd client && sh ./cicd-client.sh )
