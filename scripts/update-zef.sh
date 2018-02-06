#! /usr/bin/env sh

readonly DEPS="git"
readonly WORKDIR=$(mktemp -d)

build()
{
	perl6 -I. bin/zef install .
}

cleanup()
{
	rm -rf "$WORKDIR"
	apt remove $DEPS
	apt autoremove
}

prepare()
{
	apt update
	apt install -y $DEPS

	git clone https://github.com/ugexe/zef "$WORKDIR"
	cd "$WORKDIR" || exit
}

main()
{
	# Curl is needed in order to use zef
	apt install curl

	# Bootstrap zef
	prepare
	build
	cleanup
}

main "$@"
