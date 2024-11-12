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


if [ -z "$(which dot)" ]; then
	echoError "'graphiz' not found or not installed."
	exit 1
fi

if [ -z "$(which python)" ]; then
	echoError "'python' not found or not installed."
	exit 1
fi

if [ -z "$(which pyreverse)" ]; then
	echoError "'pylint' not found or not installed."
	exit 1
fi

if [ -z "$(which code2flow)" ]; then
	echoError "'code2flow' not found or not installed."
	exit 1
fi


# Loading .env file (if exists):
if [ -f ".env" ]; then
	# shellcheck disable=SC1091
	source .env
fi
## --- Base --- ##


## --- Variables --- ##
# Load from envrionment variables:
MODULE_NAME="${MODULE_NAME:-simple_model}"
MODULE_DIR="${MODULE_DIR:-./src/${MODULE_NAME}}"
OUTPUT_DIR="${OUTPUT_DIR:-./docs/diagrams}"


_MODULE_NAME=""
_MODULE_DIR=""
_OUTPUT_DIR=""
## --- Variables --- ##


## --- Main --- ##
main()
{
	## --- Menu arguments --- ##
	if [ -n "${1:-}" ]; then
		for _input in "${@:-}"; do
			case ${_input} in
				-m=* | --module-name=*)
					_MODULE_NAME="${_input#*=}"
					shift;;
				-d=* | --module-dir=*)
					_MODULE_DIR="${_input#*=}"
					shift;;
				-o=* | --output-dir=*)
					_OUTPUT_DIR="${_input#*=}"
					shift;;
				*)
					echoError "Failed to parsing input -> ${_input}"
					echoInfo "USAGE: ${0}  -m=*, --module-name=* [simple_model] | -d=*, --module-dir=* [./src/simple_model] | -o=*, --output-dir=* [./docs/diagrams]"
					exit 1;;
			esac
		done
	fi
	## --- Menu arguments --- ##


	if [ -z "${_MODULE_NAME:-}" ]; then
		_MODULE_NAME="${MODULE_NAME}"
	else
		MODULE_DIR="./src/${_MODULE_NAME}"
	fi

	if [ -z "${_MODULE_DIR:-}" ]; then
		_MODULE_DIR="${MODULE_DIR}"
	fi

	if [ -z "${_OUTPUT_DIR:-}" ]; then
		_OUTPUT_DIR="${OUTPUT_DIR}"
	fi

	_classess_dir="${_OUTPUT_DIR}/classes"
	_packages_dir="${_OUTPUT_DIR}/packages"
	_flowchart_dir="${_OUTPUT_DIR}/flowcharts"

	if [ ! -d "${_classess_dir}" ]; then
		mkdir -p "${_classess_dir}"
	fi

	if [ ! -d "${_packages_dir}" ]; then
		mkdir -p "${_packages_dir}"
	fi

	if [ ! -d "${_flowchart_dir}" ]; then
		mkdir -p "${_flowchart_dir}"
	fi


	echoInfo "Generating UML diagrams..."
	pyreverse -d "${_OUTPUT_DIR}" -o html -p "${_MODULE_NAME}" "${_MODULE_DIR}"
	pyreverse -d "${_OUTPUT_DIR}" -o pdf -p "${_MODULE_NAME}" "${_MODULE_DIR}"
	pyreverse -d "${_OUTPUT_DIR}" -o png -p "${_MODULE_NAME}" "${_MODULE_DIR}"
	pyreverse -d "${_OUTPUT_DIR}" -o svg -p "${_MODULE_NAME}" "${_MODULE_DIR}"

	mv -vf "${_OUTPUT_DIR}/classes_${_MODULE_NAME}.html" "${_classess_dir}/"
	mv -vf "${_OUTPUT_DIR}/classes_${_MODULE_NAME}.pdf" "${_classess_dir}/"
	mv -vf "${_OUTPUT_DIR}/classes_${_MODULE_NAME}.png" "${_classess_dir}/"
	mv -vf "${_OUTPUT_DIR}/classes_${_MODULE_NAME}.svg" "${_classess_dir}/"

	mv -vf "${_OUTPUT_DIR}/packages_${_MODULE_NAME}.html" "${_packages_dir}/"
	mv -vf "${_OUTPUT_DIR}/packages_${_MODULE_NAME}.pdf" "${_packages_dir}/"
	mv -vf "${_OUTPUT_DIR}/packages_${_MODULE_NAME}.png" "${_packages_dir}/"
	mv -vf "${_OUTPUT_DIR}/packages_${_MODULE_NAME}.svg" "${_packages_dir}/"

	code2flow -o "${_flowchart_dir}/flowchart_${_MODULE_NAME}.png" "${_MODULE_DIR}"
	code2flow -o "${_flowchart_dir}/flowchart_${_MODULE_NAME}.svg" "${_MODULE_DIR}"
	echoOk "Done."
}

main "${@:-}"
## --- Main --- ##
