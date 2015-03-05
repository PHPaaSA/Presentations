#!/usr/bin/env bash
#
# Update GIT Modules
#
# Author: Sam Likins <sam.likins@wsi-services.com>

GIT_DIR="$(dirname $(dirname $(readlink -f ${BASH_SOURCE[0]})))"

(
	cd $GIT_DIR;
	git submodule update --init --recursive
)