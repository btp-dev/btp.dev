set positional-arguments
set ignore-comments

# build an image
build app name:
	podman build \
		--build-arg pgk=app \
		--build-arg env=name \
		-t {{app}}:{{name}} \
		.

# build an image, then run the container
run app name port: (build app name)
	podman run \
		--rm \
		-it \
		-d \
		--name {{app}}-{{name}} \
		-p {{port}}:80 {{app}}:{{name}}
	podman image prune -f

# stop the latest container
stop app name:
	podman stop {{app}}-{{name}}

# prune all hanging images, containers, and volumes
prune:
	podman image prune -f
	podman container prune -f
	podman volume prune -f
	podman network prune -f

# Stop the container and prune all hanging images, containers, and volumes
kill app name: (stop app name)(prune)

# remove a specific image
rm app name:
	podman rmi {{app}}:{{name}}

# Follow the container's logs
logs app name:
	tail -f | podman logs {{app}}-{{name}}
