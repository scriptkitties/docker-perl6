FROM debian:stable
LABEL maintainer="Patrick Spek <p.spek@tyil.work>"

WORKDIR /perl6

# Prepare system
RUN apt update
RUN apt -y install build-essential curl git

# Setup rakudobrew
RUN git clone https://github.com/tadzik/rakudobrew

RUN printf "%s\n" 'export PATH=/perl6/rakudobrew/bin:$PATH' >> /etc/profile
RUN printf "%s\n" 'eval "$(/perl6/rakudobrew/bin/rakudobrew init -)"' >> /etc/profile

ENV PATH="/perl6/rakudobrew/bin:${PATH}"

# Compile Rakudo Perl 6
RUN rakudobrew build moar 2018.01
RUN rakudobrew build zef
RUN rakudobrew rehash

# Install nice things
RUN zef install Test::META

# Cleanup system
RUN apt -y remove build-essential
RUN apt -y autoremove

# Prepare for use as a base template
WORKDIR /app
