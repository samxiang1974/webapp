#!/bin/bash
# cicd-server.sh: CICD process for webapp app services

# source stage
# git clone from github

set -exf 
DBHOST=$1
DBPASSWORD=$2

# commit stage
CI_COMMIT_SHORT_SHA=$(date +%s)
CONTAINER_IMAGE="samxiang1974/server:${CI_COMMIT_SHORT_SHA}"
DOCKER_USERNAME=samxiang1974
DOCKER_PASSWORD=
docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
docker build -t ${CONTAINER_IMAGE} .
docker push ${CONTAINER_IMAGE}
echo "docker image created"

# deploy stage
PACKAGE=server-chart

cd ${PACKAGE}
DEPLOYED=$(helm list |grep -E "^${PACKAGE}" |grep DEPLOYED |wc -l)
if [ $DEPLOYED -eq 0 ] ; then
  helm install --namespace webapp  --wait --set mariadb.hostname=${DBHOST} --set mariadb.db.password=${DBPASSWORD} --set-string image.tag=${CI_COMMIT_SHORT_SHA} --name ${PACKAGE} .
else
  helm upgrade --namespace webapp --wait --set mariadb.db.password=${DBPASSWORD} --set-string image.tag=${CI_COMMIT_SHORT_SHA} ${PACKAGE} .
fi
echo "deployed!"
