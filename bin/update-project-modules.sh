#!/usr/bin/env bash
#
# Update Project from GIT Modules
#
# Author: Sam Likins <sam.likins@wsi-services.com>

GIT_DIR="$(dirname $(dirname $(readlink -f ${BASH_SOURCE[0]})))"
MODULES_DIR="$GIT_DIR/modules"
SOURCE_DIR="$GIT_DIR/source"

function update_project {
	local MODULE="$1"
	local SOURCE_PATH="$2"
	local DEST_PATH="$3"

	cp  --recursive \
		$MODULES_DIR/$MODULE/$SOURCE_PATH \
		$SOURCE_DIR/$DEST_PATH
}

function project_remove {
	local TARGET_PATH="$1"

	rm $SOURCE_DIR/$TARGET_PATH
}

function string_escape_slashes {
	local SUBJECT="$1"

	echo "$SUBJECT" | sed -e "s|/|\\\/|g"
}

function replace_string {
	local FILENAME="$1"
	local NEEDLE="$(string_escape_slashes "$2")"
	local REPLACE="$(string_escape_slashes "$3")"

	sed -i "s/$NEEDLE/$REPLACE/g" $SOURCE_DIR/$FILENAME
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

update_project impress.js	js/impress.js		assets/js/impress.js

update_project reveal.js	js/reveal.min.js	assets/js/reveal.min.js
update_project reveal.js	plugin/*			assets/js/plugin/
update_project reveal.js	lib/js/*			assets/js/
update_project reveal.js	css/reveal.min.css	assets/css/reveal.min.css
update_project reveal.js	css/print/*.css		assets/css/print/
update_project reveal.js	css/theme/*.css		assets/css/theme/
update_project reveal.js	lib/css/*.css		assets/css/
update_project reveal.js	lib/font/*			assets/font/

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

project_remove assets/js/plugin/*/*.html
project_remove assets/js/plugin/*/*.md

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

replace_string assets/css/theme/*	"\"../../lib/font" "\"../../font"
