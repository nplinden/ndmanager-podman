This repository provides a Dockefile and a script for running [NDManager](https://github.com/nplinden/ndmanager) in a containerized fashion.

Podman is preferred over Docker because files created on the host by the Docker container's root user will be owned by the host's root user on the host system.
Using Podman however, the files will be owned by the user who started the container.

More info [here](https://unix.stackexchange.com/questions/627027/files-created-by-docker-container-are-owned-by-root)