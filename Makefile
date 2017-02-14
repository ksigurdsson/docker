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

build-vivado-2016-3:
	@cd images/xilinx-vivado/2016-3; docker build -t vivado/2016-3 .

build-taskjuggler:
	@cd images/taskjuggler; docker build -t taskjuggler .

build-icarus:
	@cd images/icarus-verilog; docker build -t icarus-verilog .

serve-src:
	@cd images/src; python3.4 -m http.server --bind $(IP) 8000
# -----------------------------------------------------------------------------
# Run Targets
# -----------------------------------------------------------------------------

run-base:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/home:/home/$(USER):rw" \
	-e DISPLAY=$(IP):0 base tcsh

run-vivado:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/home:/home/$(USER):rw" \
	--volume="/Users/$(USER)/siglogic/asic-project:/home/$(USER)/asic-project:rw" \
	-e DISPLAY=$(IP):0 vivado/2016-3 tcsh

run-icarus:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/home:/home/$(USER):rw" \
	--volume="/Users/$(USER)/siglogic/asic-project:/home/$(USER)/asic-project:rw" \
	-e DISPLAY=$(IP):0 icarus-verilog tcsh

run-taskjuggler:
	@docker run -it --rm --user=$(USER) --workdir="/home/$(USER)" \
	--volume="/Users/$(USER)/siglogic/docker/home:/home/$(USER):rw" \
	-e DISPLAY=$(IP):0 taskjuggler tcsh

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
