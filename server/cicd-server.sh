#!/bin/bash
# cicd-server.sh: CICD process for webapp app services

# source stage
# git clone from github

# commit stage
CI_COMMIT_SHORT_SHA=$(date +%s)
CONTAINER_IMAGE="samxiang1974/server:${CI_COMMIT_SHORT_SHA}"
docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
docker build -t ${CONTAINER_IMAGE} .
docker push ${CONTAINER_IMAGE}
echo "docker image created"

# deploy stage
PACKAGE=server-chart

cd ${PACKAGE}
DEPLOYED=$(helm list |grep -E "^${PACKAGE}" |grep DEPLOYED |wc -l)
if [ $DEPLOYED == 0 ] ; then
  helm install --namespace webapp --set mariadb.db.password=${DBPASSWORD} --name ${PACKAGE} .
else
  helm upgrade --namespace webapp --set mariadb.db.password=${DBPASSWORD} ${PACKAGE} .
fi
echo "deployed!"
