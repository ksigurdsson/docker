FROM ubuntu:14.04

# Install required packages
RUN apt-get -y update && apt-get install -y \
    tcsh \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Create the staff group
#RUN addgroup --gid 20 staff

# Create the karl user in the image
RUN adduser --disabled-login \
            --gecos '' \
            --home /home/karl \
            --shell /bin/tcsh \
            --gid 20 -uid 501 karl 

#CMD [ "konsole", "-e", "/bin/bash" ]

#USER karl
#WORKDIR /home/karl
