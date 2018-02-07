#! /usr/bin/env sh

readonly DEPS="build-essential git"
readonly WORKDIR=$(mktemp -d)

build()
{
	perl Configure.pl --gen-moar --gen-nqp --backends=moar --prefix=/usr/local
	make
	make install
}

cleanup()
{
	cd || exit
	rm -rf "$WORKDIR"
	apt -y remove $DEPS
	apt -y autoremove
}

prepare()
{
	apt update
	apt install -y $DEPS

	git clone https://github.com/rakudo/rakudo/ "$WORKDIR"
	cd "$WORKDIR" || exit

	git checkout "$1"
	git pull
}

main()
{
	prepare "${1:-master}"
	build
	perl6 --version
	cleanup
}

main "$@"
