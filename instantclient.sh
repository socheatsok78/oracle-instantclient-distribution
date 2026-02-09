#!/usr/bin/env bash
set -e
ME="$(basename "$0")"
supported_variants=("basic" "basiclite")
supported_architectures=("x64" "arm64")
quiet=0
function stdout() {
	echo "$@"
}
function stderr() {
	echo "$@" >&2
}
function log.info() {
	if [[ "${quiet}" -eq 1 ]]; then
		return
	fi
	stderr "$ME: [INF] $*"
}
function log.error() {
	if [[ "${quiet}" -eq 1 ]]; then
		stderr "$*"
		return
	fi
	stderr "$ME: [ERR] $*"
}
function usage() {
	stdout "Usage: $0 <version> [variant] [arch]"
	stdout "  --version: Oracle Instant Client version (e.g. 19.8.0.0)"
	stdout "  --variant: one of ${supported_variants[*]} (default: basic)"
	stdout "  --arch: one of ${supported_architectures[*]} (default: x64)"
}
function instantclient.checkurl() {
	log.info " - Checking: $1"
	curl -s --fail --head "$1" >/dev/null
}
function instantclient.download() {
	local url output
	while [[ $# -gt 0 ]]; do
		case "$1" in
		--url)
			url="$2"
			shift 2
			;;
		--output)
			output="$2"
			shift 2
			;;
		*)
			log.error "[instantclient.download] Unknown option: $1"
			exit 1
		esac
	done
	log.info " - Downloading: $url"
	curl -L -o "$output" "$url"
}
function instantclient.otn.to_str() {
	echo "https://download.oracle.com/otn/linux/instantclient"
}
function instantclient.otn_software.to_str() {
	echo "https://download.oracle.com/otn_software/linux/instantclient"
}
function main() {
	local __command
	local version
	local variant=basic
	local arch; arch="$(uname -m)"
	while [[ $# -gt 0 ]]; do
		case "$1" in
		check|download)
			__command="$1"
			shift
			;;
		--version)
			version="$2"
			shift 2
			;;
		--variant)
			variant="$2"
			shift 2
			;;
		--arch)
			arch="$2"
			shift 2
			;;
		-q|--quiet)
			quiet=1
			shift
			;;
		--help)
			usage
			exit 0
			;;
		*)
			log.error "Unknown command: $1"
			usage
			exit 1
			;;
		esac
	done
	if [[ -z "${version}" ]]; then
		echo "Error: version is required"
		usage
		exit 1
	fi
	local lastbit instantclient
	lastbit="$(echo "$version" | cut -d. -f5)"
	if [[ -z "${lastbit}" ]]; then
		version="${version}.0"
	fi
	instantclient="$(echo "$version" | cut -d. -f1-3 | tr -d .)00"
	if [ ${#instantclient} -lt 7 ]; then
		instantclient="${instantclient}$(printf '%0.s0' $(seq 1 $((7 - ${#instantclient}))))"
	fi
	case "${__command}" in
		check)
			main.check --version "${version}" --variant "${variant}" --arch "${arch}"
		;;
		download)
			main.download --version "${version}" --variant "${variant}" --arch "${arch}"
		;;
		*)
			log.error "Unknown command: ${__command}"
			usage
			exit 1
		;;
	esac
	
}
function main.check() {
	local version variant arch
	while [[ $# -gt 0 ]]; do
		case "$1" in
		--version)
			version="$2"
			shift 2
			;;
		--variant)
			variant="$2"
			shift 2
			;;
		--arch)
			arch="$2"
			shift 2
			;;
		*)
			log.error "[main.check] Unknown option: $1"
			exit 1
		esac
	done
	if instantclient.checkurl "$(instantclient.otn_software.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}.zip"; then
		stdout "$(instantclient.otn_software.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}.zip"
		exit 0
	elif instantclient.checkurl "$(instantclient.otn_software.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}dbru.zip"; then
		stdout "$(instantclient.otn_software.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}dbru.zip"
		exit 0
	elif [[ "${arch}" != "arm64" ]]; then
		instantclient="$(echo "$version" | cut -d. -f1-4 | tr -d .)"
		if instantclient.checkurl "$(instantclient.otn.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}.zip"; then
			stdout "$(instantclient.otn.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}.zip"
			exit 0
		elif instantclient.checkurl "$(instantclient.otn.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}dbru.zip"; then
			stdout "$(instantclient.otn.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}dbru.zip"
			exit 0
		else
			log.error "No download available for ${variant} ${arch} ${version}"
			exit 1
		fi
	else
		log.error "No download available for ${variant} ${arch} ${version}"
		exit 1
	fi
}
function main.download() {
	local version variant arch
	while [[ $# -gt 0 ]]; do
		case "$1" in
		--version)
			version="$2"
			shift 2
			;;
		--variant)
			variant="$2"
			shift 2
			;;
		--arch)
			arch="$2"
			shift 2
			;;
		*)
			log.error "[main.download] Unknown option: $1"
			exit 1
		esac
	done
	if instantclient.checkurl "$(instantclient.otn_software.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}.zip"; then
		instantclient.download \
			--url "$(instantclient.otn_software.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}.zip" \
			--output "instantclient-${variant}-linux.${arch}-${version}.zip"
		exit 0
	elif instantclient.checkurl "$(instantclient.otn_software.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}dbru.zip"; then
		instantclient.download \
			--url "$(instantclient.otn_software.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}dbru.zip" \
			--output "instantclient-${variant}-linux.${arch}-${version}dbru.zip"
		exit 0
	elif [[ "${arch}" != "arm64" ]]; then
		instantclient="$(echo "$version" | cut -d. -f1-4 | tr -d .)"
		if instantclient.checkurl "$(instantclient.otn.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}.zip"; then
			instantclient.download \
				--url "$(instantclient.otn.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}.zip" \
				--output "instantclient-${variant}-linux.${arch}-${version}.zip"
			exit 0
		elif instantclient.checkurl "$(instantclient.otn.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}dbru.zip"; then
			instantclient.download \
				--url "$(instantclient.otn.to_str)/${instantclient}/instantclient-${variant}-linux.${arch}-${version}dbru.zip" \
				--output "instantclient-${variant}-linux.${arch}-${version}dbru.zip"
			exit 0
		else
			log.error "No download available for ${variant} ${arch} ${version}"
			exit 1
		fi
	else
		log.error "No download available for ${variant} ${arch} ${version}"
		exit 1
	fi
}
main "$@"
