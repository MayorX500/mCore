#!/bin/bash

image_name=mcore
container_name=core

create_image () {
	
	docker build -t $image_name .

}

start_container () {
	docker run -itd --restart unless-stopped --name $container_name -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v $HOME/Documents/Core:/root:rw --privileged $image_name /usr/local/bin/core-daemon

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
xhost +local:root &&\\
docker exec -it $container_name core-gui-legacy

" > ./core.sh

}

write_executable_shell () {
	
	echo -ne "#!/bin/bash
xhost +local:root &&\\
docker exec -it $container_name bash

" > ./core_bash.sh

}

write_sh () {
	write_executable
	write_executable_shell
	write_uninstall
}

main () {

	mkdir -p $HOME/Documents/Core
	create_image
	start_container
	write_sh

}

main

