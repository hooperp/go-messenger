Version=0.1
RepositoryName=phooper0001
AppName=vocalink-test-app-1
ImageName=$RepositoryName/$AppName:$Version

[ -z "$DOCKER_USERNAME" -o -z "$DOCKER_PASSWORD" ] && { echo "Please enter DOCKER_USERNAME and DOCKER_PASSWORD" ; exit 1 ; } 

docker build --force-rm -t $ImageName .
docker run -d -t $ImageName bash

ContainerId=$(docker ps | grep "$ImageName" | awk ' { print $1 } ' ) 

echo "docker commit $ContainerId $ImageName"
docker commit $ContainerId $ImageName

docker login --password $DOCKER_PASSWORD --username $DOCKER_USERNAME

echo "docker push $ImageName"
docker push $ImageName

./DockerDelete.sh
