FROM ubuntu:14.04
RUN apt-get -y update
RUN apt-get install -y tcsh

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
