FROM debian:stable
LABEL maintainer="Patrick Spek <p.spek@tyil.work>"

ARG RELEASE=master

# Update shell profile
COPY ./scripts/profile.sh /etc/profile.d/perl6
RUN . /etc/profile.d/perl6

# Install Rakudo Perl 6
COPY ./scripts/update-perl6.sh /usr/bin/update-perl6
RUN update-perl6 $RELEASE

# Install zef
COPY ./scripts/update-zef.sh /usr/bin/update-zef
RUN update-zef

# Prepare for use as a base template
WORKDIR /app
