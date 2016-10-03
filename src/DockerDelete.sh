docker rm -f $(docker ps -a | awk ' { print $1 } ' | grep -v CONTAINER)
docker rmi -f $(docker images | grep -v CREATED  | awk ' { print $3 } ')
