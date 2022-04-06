#!/bin/bash

image_name=mcore:latest
container_name=core

function create_image {
	
	docker build -t $image_name .

}

function start_container {
	docker run -itd --restart unless-stopped --name $container_name -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw --privileged $image_name /usr/local/bin/core-daemon

}


function write_executable {
	
	echo -ne "#!/bin/bash
if \$(docker ps | grep $container_name)
then
	docker start $container_name
fi

xhost +local:root &&\\
docker exec -it $container_name core-gui-legacy

" > ./core.sh

}

function main {

	create_image
	start_container
	write_executable

}

main

