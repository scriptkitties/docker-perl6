FROM debian:stable
LABEL maintainer="Patrick Spek <p.spek@tyil.work>"

ARG RELEASE=master

# Update shell profile
COPY ./scripts/bashrc.sh /root/.bashrc

# Install Rakudo Perl 6
COPY ./scripts/update-perl6.sh /usr/bin/update-perl6
RUN update-perl6 $RELEASE

# Install zef
COPY ./scripts/update-zef.sh /usr/bin/update-zef
RUN update-zef

# Prepare for use as a base template
WORKDIR /app
