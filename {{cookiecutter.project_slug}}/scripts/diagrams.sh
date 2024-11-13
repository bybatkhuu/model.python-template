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
MODULE_NAME="${MODULE_NAME:-{{cookiecutter.module_name}}}"
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
					echoInfo "USAGE: ${0}  -m=*, --module-name=* [{{cookiecutter.module_name}}] | -d=*, --module-dir=* [./src/{{cookiecutter.module_name}}] | -o=*, --output-dir=* [./docs/diagrams]"
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

	_classes_dir="${_OUTPUT_DIR}/classes"
	_packages_dir="${_OUTPUT_DIR}/packages"
	_cgraphs_dir="${_OUTPUT_DIR}/call-graphs"

	if [ ! -d "${_classes_dir}" ]; then
		mkdir -vp "${_classes_dir}"
	fi

	if [ ! -d "${_packages_dir}" ]; then
		mkdir -vp "${_packages_dir}"
	fi

	if [ ! -d "${_cgraphs_dir}" ]; then
		mkdir -vp "${_cgraphs_dir}"
	fi


	echoInfo "Generating UML diagrams..."
	_cp_formats=("html" "pdf" "png" "svg")
	for _cp_format in "${_cp_formats[@]}"; do
		_tmp_class_path="${_OUTPUT_DIR}/classes_${_MODULE_NAME}.${_cp_format}"
		_tmp_package_path="${_OUTPUT_DIR}/packages_${_MODULE_NAME}.${_cp_format}"

		echoInfo "Generating ['${_tmp_class_path}', '${_tmp_package_path}'] files..."
		pyreverse -d "${_OUTPUT_DIR}" -o "${_cp_format}" -p "${_MODULE_NAME}" "${_MODULE_DIR}" || exit 2
		mv -vf "${_tmp_class_path}" "${_classes_dir}/" || exit 2
		mv -vf "${_tmp_package_path}" "${_packages_dir}/" || exit 2
		echoOk "Done."
	done

	_cgraph_formats=("png" "svg")
	for _cgraph_format in "${_cgraph_formats[@]}"; do
		_cgraph_path="${_cgraphs_dir}/cgraph_${_MODULE_NAME}.${_cgraph_format}"

		echoInfo "Generating '${_cgraph_path}' file..."
		code2flow -o "${_cgraph_path}" "${_MODULE_DIR}" || exit 2
		echoOk "Done."
	done
	echoOk "Done."
}

main "${@:-}"
## --- Main --- ##
