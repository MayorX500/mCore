#!/bin/bash

image_name=mcore:latest
container_name=core

create_image () {
	
	docker build -t $image_name .

}

start_container () {
	docker run -itd --restart unless-stopped --name $container_name -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw --privileged $image_name /usr/local/bin/core-daemon

}

write_uninstall () {

	echo -ne "#!/bin/bash

docker rm -f core && \
	docker rmi mcore && \
	sudo rm -f /usr/local/bin/core-gui /usr/local/bin/core-uninstall

" > ./core-uninstall.sh

}

write_executable () {
	
	echo -ne "#!/bin/bash
if \$(docker ps | grep $container_name)
then
	docker start $container_name
fi

xhost +local:root &&\\
docker exec -it $container_name core-gui-legacy

" > ./core.sh

}

write_sh () {
	write_executable
	write_uninstall
}

main () {

	create_image
	start_container
	write_sh

}

main

