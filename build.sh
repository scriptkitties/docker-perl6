#! /usr/bin/env sh

main()
{
	release=${1:-master}
	tag=${1:-latest}

	[ -n "$1" ] && args=" --no-cache"

	shift

	args="$args $*"

	docker build \
		-t "scriptkitties/perl6:$tag" \
		--build-arg "RELEASE=$release" \
		$args \
		.
}

main "$@"
