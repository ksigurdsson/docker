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
# Build Targets
# -----------------------------------------------------------------------------

build-vivado-2016-1:
	@cd images/xilinx-vivado/2016-1; docker build -t vivado/2016-1 .

build-vivado-2016-3:
	@cd images/xilinx-vivado/2016-3; docker build -t vivado/2016-3 .

build-taskjuggler:
	@cd images/taskjuggler; docker build -t taskjuggler .

build-sigrok:
	@cd images/sigrok; docker build -t sigrok .

serve-src:
	@cd images/src; python3.4 -m http.server --bind $(IP) 8000

# -----------------------------------------------------------------------------
# Docker Machine Targets
# -----------------------------------------------------------------------------

start:
	@docker-machine start main
	@docker-machine env main --shell=tcsh

stop:
	@docker-machine stop main

# -----------------------------------------------------------------------------
# Run Targets
# -----------------------------------------------------------------------------

run-vivado:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/home:/home/$(USER):rw" \
	--volume="/Users/$(USER)/siglogic/asic-project:/home/$(USER)/asic-project:rw" \
	-e DISPLAY=$(IP):0 vivado/2016-3 tcsh

run-taskjuggler:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/home:/home/$(USER):rw" \
	-e DISPLAY=$(IP):0 taskjuggler tcsh

run-sigrok:
	@docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/home:/home/$(USER):rw" \
	-e DISPLAY=$(IP):0 sigrok tcsh

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
