FROM base
RUN apt-get -y update
RUN apt-get install -y nano make

# Need ruby to install the taskjuggler gem
RUN apt-get install -y ruby2.0 \
    && rm /usr/bin/ruby && ln -s /usr/bin/ruby2.0 /usr/bin/ruby \
    && rm -rf /usr/bin/gem && ln -s /usr/bin/gem2.0 /usr/bin/gem

# Install taskjuggler
RUN gem install taskjuggler
