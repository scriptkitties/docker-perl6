#! /usr/bin/env sh

main()
{
	release=${1:-master}
	tag=${1:-latest}

	docker build \
		-t "scriptkitties/perl6:$tag" \
		--build-arg "RELEASE=$release" \
		.
}

main "$@"
