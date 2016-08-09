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

build-base:
	@cd images/base; docker build -t base .

build-vivado-2016-1:
	@cd images/xilinx-vivado/2016-1; docker build -t vivado/2016-1 .

build-taskjuggler:
	@cd images/taskjuggler; docker build -t taskjuggler .

# -----------------------------------------------------------------------------
# Run Targets
# -----------------------------------------------------------------------------

run-base:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/tmp:/home/$(USER):rw" \
	-e DISPLAY=$(IP):0 base tcsh

run-vivado-2016-1:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/tmp:/home/$(USER):rw" \
	-e DISPLAY=$(IP):0 vivado/2016-1 tcsh

run-taskjuggler:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/tmp:/home/$(USER):rw" \
	-e DISPLAY=$(IP):0 taskjuggler tcsh

# -----------------------------------------------------------------------------
# Misc Targets
# -----------------------------------------------------------------------------

list-containers:
	@docker ps -a

list-images:
	@docker images

delete-all-containers:
	@docker rm `docker ps -a -q`


.PHONY:	run-base
