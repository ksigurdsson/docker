FROM base

# Install required packages
# ruby required to install the taskjuggler gem
RUN apt-get -y update && apt-get install -y \
    make \
    ruby2.0 \
    && rm -rf /var/lib/apt/lists/* \
    && rm /usr/bin/ruby && ln -s /usr/bin/ruby2.0 /usr/bin/ruby \
    && rm -rf /usr/bin/gem && ln -s /usr/bin/gem2.0 /usr/bin/gem

# Install taskjuggler
RUN gem install taskjuggler
