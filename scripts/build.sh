#!/bin/bash
set -euo pipefail


## --- Base --- ##
# Getting path of this script file:
_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
_PROJECT_DIR="$(cd "${_SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd)"
cd "${_PROJECT_DIR}" || exit 2

# Loading base script:
# shellcheck disable=SC1091
source ./scripts/base.sh

# Checking 'cookiecutter' is installed or not:
if [ -z "$(which cookiecutter)" ]; then
	echoError "'cookiecutter' not found or not installed."
	exit 1
fi
## --- Base --- ##


## --- Main --- ##
main()
{
	echoInfo "Generating cookiecutter project..."
	cookiecutter -f .
	echoOk "Done."
}

main "${@:-}"
## --- Main --- ##
