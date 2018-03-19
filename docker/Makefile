###############################################################################
# Docker Makefile
###############################################################################

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

USER = $(shell whoami)

# -----------------------------------------------------------------------------
# The first target is help
# -----------------------------------------------------------------------------

help:
	@echo ""
	@echo "The following targets are available:"
	@echo "------------------------------------"
	@egrep '^[0-9a-zA-Z\#_-]+:' Makefile | cut -f1 -d":" | uniq | more
	@echo ""

# -----------------------------------------------------------------------------
# Docker Base Build Targets
# -----------------------------------------------------------------------------

build-1604:
	@docker build --file Dockerfile-16.04 --tag base:16.04 .

# -----------------------------------------------------------------------------
# Docker Base Run Targets
# -----------------------------------------------------------------------------

run:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/home:/home/$(USER):rw" \
	base:16.04 tcsh

# -----------------------------------------------------------------------------
# Docker Machine Targets
# -----------------------------------------------------------------------------

start:
	@docker-machine start main
	@docker-machine env main --shell=tcsh

stop:
	@docker-machine stop main

# -----------------------------------------------------------------------------
# Docker Misc Targets
# -----------------------------------------------------------------------------

list-cont:
	@docker ps -a

list-imag:
	@docker images

del-all-cont:
	@docker rm `docker ps -a -q`

del-all-imag:
	@docker rmi `docker images -q `

clean:
	@rm ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2

.PHONY:	run
