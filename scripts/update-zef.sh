#! /usr/bin/env sh

readonly WORKDIR=$(mktemp -d)

build()
{
	perl6 -I. bin/zef install .
}

cleanup()
{
	cd || exit
	rm -rf "$WORKDIR"
	apt -y autoremove
}

prepare()
{
	apt update

	git clone https://github.com/ugexe/zef "$WORKDIR"
	cd "$WORKDIR" || exit
}

main()
{
	# Curl and git are backends for zef's fetching mechanism, so they need not
	# be deleted afterwards.
	apt install -y curl git

	# Bootstrap zef
	prepare
	build
	cleanup
}

main "$@"
