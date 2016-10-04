Version=0.1
RepositoryName=phooper0001
AppNames="vocalink-test-app-1 vocalink-test-app-2 vocalink-test-app-3"

[ -z "$DOCKER_USERNAME" -o -z "$DOCKER_PASSWORD" ] && { echo "Please enter DOCKER_USERNAME and DOCKER_PASSWORD" ; exit 1 ; } 

for AppName in $AppNames
do

    ImageName=$RepositoryName/$AppName:$Version

    cd $AppName

    docker build --force-rm -t $ImageName .
    docker run -d -t $ImageName bash

    ContainerId=$(docker ps | grep "$ImageName" | awk ' { print $1 } ' ) 

    echo "docker commit $ContainerId $ImageName"
    docker commit $ContainerId $ImageName
    
    docker login --password $DOCKER_PASSWORD --username $DOCKER_USERNAME
    
    echo "docker push $ImageName"
    docker push $ImageName

    cd - 

done

./DockerDelete.sh
