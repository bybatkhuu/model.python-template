#!/bin/bash
set -euo pipefail


## --- Base --- ##
# Getting path of this script file:
_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
_PROJECT_DIR="$(cd "${_SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd)"
cd "${_PROJECT_DIR}" || exit 2

# Checking 'cookiecutter' is installed or not:
if [ -z "$(which cookiecutter)" ]; then
	echo "[ERROR]: 'cookiecutter' not found or not installed."
	exit 1
fi
## --- Base --- ##


## --- Main --- ##
main()
{
	echo "[INFO]: Generating cookiecutter project..."
	cookiecutter -f .
	echo "[OK]: Done."
}

main "${@:-}"
## --- Main --- ##
