###############################################################################
# Docker Makefile
###############################################################################

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

IP   = $(shell ifconfig en1 | grep inet | grep -v inet6 | awk '$$1=="inet" {print $$2}')
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
# Docker Machine Targets
# -----------------------------------------------------------------------------

start:
	@docker-machine start main
	@docker-machine env main --shell=tcsh

stop:
	@docker-machine stop main

# -----------------------------------------------------------------------------
# Misc Targets
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

.PHONY:	run-base
