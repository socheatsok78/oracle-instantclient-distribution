#!/usr/bin/env bash

read_dom () {
    local IFS=\>
    read -d \< ENTITY CONTENT
}

function releases() {
    while read_dom; do
        if [[ "${ENTITY}" == "version" ]]; then
            echo "$CONTENT"
        fi
    done < <(curl -sL https://repo1.maven.org/maven2/com/oracle/database/jdbc/ucp/maven-metadata.xml)
}

releases | sort -r --version-sort | jq -R '[.]' | jq -sr 'add'
