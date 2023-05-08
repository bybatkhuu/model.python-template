#!/bin/bash
set -euo pipefail


## --- Base --- ##
# Getting path of this script file:
_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
_PROJECT_DIR="$(cd "${_SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd)"
cd "${_PROJECT_DIR}" || exit 2

# Loading base script:
# shellcheck disable=SC1091
source "${_SCRIPT_DIR}/base.sh"

exitIfNoGit

# Loading .env file:
if [ -f ".env" ]; then
	# shellcheck disable=SC1091
	source .env
fi
## --- Base --- ##


## --- Variables --- ##
# Load from envrionment variables:
VERSION_FILENAME="${VERSION_FILENAME:-model/__version__.py}"
## --- Variables --- ##


## --- Main --- ##
main()
{
	echoInfo "Checking version..."
	_old_version=""
	if [ -n "${VERSION_FILENAME}" ] && [ -f "${VERSION_FILENAME}" ]; then

		echoInfo "Found version file: '${VERSION_FILENAME}'"
		_old_version=$(< "${VERSION_FILENAME}" grep "__version__ = " | awk -F' = ' '{print $2}' | tr -d '"') || exit 2

	# Check if there are any tags matching the pattern "v*.*.*-*":
	elif [ -n "$(git tag -l 'v*.*.*-*')" ]; then

		echoInfo "Found version tag."
		# Get the most recent tag which matches the pattern "v*.*.*-*":
		_tag=$(git describe --tags --match "v*.*.*-*" --abbrev=0) || exit 2

		# Strip the leading "v" character from the tag name (if present)
		_old_version=${_tag#v}
	else
		echoWarn "Not found any version tags or file, using initial version."
		_old_version="0.0.0-$(date -u '+%y%m%d')"
	fi
	echoOk "Old version: '${_old_version}'"


	# Split the version string into its components:
	_major=$(echo "${_old_version}" | cut -d. -f1)
	_minor=$(echo "${_old_version}" | cut -d. -f2)
	_patch=$(echo "${_old_version}" | cut -d. -f3 | cut -d- -f1)


	# Checking bump type is empty:
	_bump_type=${1:-}
	if [ -z "${_bump_type:-}" ]; then
		# Default to a patch bump:
		# _bump_type="patch"

		echoError "Bump type is empty!"
		exit 1
	fi

	_new_version=${_old_version}
	# Determine the new version based on the type of bump:
	if [ "${_bump_type}" == "major" ]; then
		_new_version="$((_major + 1)).0.0-$(date -u '+%y%m%d')"
	elif [ "${_bump_type}" == "minor" ]; then
		_new_version="${_major}.$((_minor + 1)).0-$(date -u '+%y%m%d')"
	elif [ "${_bump_type}" == "patch" ]; then
		_new_version="${_major}.${_minor}.$((_patch + 1))-$(date -u '+%y%m%d')"
	else
		echoError "Bump type '${_bump_type}' is invalid, should be: 'major', 'minor', 'patch'!"
		exit 1
	fi

	if git rev-parse "v${_new_version}" > /dev/null 2>&1; then
		echoError "'v${_new_version}' tag is already exists."
		exit 1
	else
		echoInfo "Bumping version to '${_new_version}'..."
		if [ -n "${VERSION_FILENAME}" ] && [ -f "${VERSION_FILENAME}" ]; then
			# Update the version file with the new version:
			echo -e "# -*- coding: utf-8 -*-\n\n__version__ = \"${_new_version}\"" > "${VERSION_FILENAME}" || exit 2

			# Commit the updated version file:
			git add "${VERSION_FILENAME}" || exit 2
			git commit -m ":bookmark: Bump version to ${_new_version}." || exit 2
			git push || exit 2
		fi

		git tag "v${_new_version}" || exit 2
		git push origin "v${_new_version}" || exit 2

		echoOk "New version: '${_new_version}'"
	fi
}

main "${@:-}"
## --- Main --- ##
