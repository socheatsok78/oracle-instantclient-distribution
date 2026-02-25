#!/usr/bin/env bash

SCRIPTDIR="$(dirname "$(realpath "$0")")"
TAGS_FILE="${1:-tags.json}"

for version in `cat "${TAGS_FILE}" | jq -r '. | join("\n")'`; do
	echo "{"
	echo "  \"$version\": {"
	for variant in basic basiclite; do
		echo "    \"$variant\": {"
		for arch  in x64 arm64; do
			url=$("${SCRIPTDIR}/instantclient.sh" check --quiet --version "$version" --variant "$variant" --arch "$arch" 2>/dev/null)
			if [ -n "$url" ]; then
				echo "      \"$arch\": \"$url\"$([ "$arch" = "x64" ] && echo "," || echo "")"
			else
				echo "      \"$arch\": null$([ "$arch" = "x64" ] && echo "," || echo "")"
			fi
		done
		echo "    }$([ "$variant" = "basic" ] && echo "," || echo "")"
	done
	echo "  }"
	echo "}"
done
