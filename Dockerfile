FROM debian:stable
LABEL maintainer="Patrick Spek <p.spek@tyil.work>"

ARG RELEASE=master

# Update shell profile for interactive use
COPY ./scripts/profile.sh /etc/profile
COPY ./scripts/shrc.sh /root/.bashrc
COPY ./scripts/shrc.sh /root/.shrc

# Update PATH for the current session
ENV PATH "/usr/local/share/perl6/site/bin:$PATH"

# Install Rakudo Perl 6
COPY ./scripts/update-perl6.sh /usr/bin/update-perl6
RUN update-perl6 $RELEASE

# Install zef
COPY ./scripts/update-zef.sh /usr/bin/update-zef
RUN update-zef

# Prepare for use as a base template
WORKDIR /app
