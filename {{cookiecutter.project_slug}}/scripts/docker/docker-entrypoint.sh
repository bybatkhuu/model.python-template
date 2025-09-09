#!/bin/bash
set -euo pipefail


echo "[INFO]: Running '${PROJECT_SLUG}' docker-entrypoint.sh..."

_doStart()
{
	if [ -n "${JUPYTERLAB_TOKEN:-}" ]; then
		echo -e "c.IdentityProvider.token = '${JUPYTERLAB_TOKEN}'" >> "/home/${USER}/.jupyter/jupyter_server_config.py" || exit 2
	fi

	echo "[INFO]: Starting Jupyter Lab..."
	exec jupyter lab --port="${JUPYTERLAB_PORT:-8888}" || exit 2
	exit 0
}


main()
{
	umask 0002 || exit 2
	find "${WORKSPACES_DIR}" \( \
		-type d -name ".git" -o \
		-type d -name ".venv" -o \
		-type d -name "modules" -o \
		-type d -name "volumes" \
		\) -prune -o -print0 | sudo xargs -0 chown -c "${USER}:${GROUP}" || exit 2

	# find "${PROJECT_DIR}" \( \
	# 	-type d -name ".git" -o \
	# 	-type d -name ".venv" -o \
	# 	-type d -name "scripts" -o \
	# 	-type d -name "modules" -o \
	# 	-type d -name "volumes" \
	# 	\) -prune -o -type d -exec sudo chmod -c 775 {} + || exit 2

	# find "${PROJECT_DIR}" \( \
	# 	-type d -name ".git" -o \
	# 	-type d -name ".venv" -o \
	# 	-type d -name "scripts" -o \
	# 	-type d -name "modules" -o \
	# 	-type d -name "volumes" -o \
	# 	-type d -name "examples" \
	# 	\) -prune -o -type f -exec sudo chmod -c 664 {} + || exit 2

	# find "${PROJECT_DIR}" \( \
	# 	-type d -name ".git" -o \
	# 	-type d -name ".venv" -o \
	# 	-type d -name "scripts" -o \
	# 	-type d -name "modules" -o \
	# 	-type d -name "volumes" \
	# 	\) -prune -o -type d -exec sudo chmod -c ug+s {} + || exit 2

	jupyter labextension disable "@jupyterlab/apputils-extension:announcements" || exit 2
	sudo /usr/sbin/sshd -p "${SSH_PORT:-22}" || exit 2
	echo "${USER} ALL=(ALL) ALL" | sudo tee -a "/etc/sudoers.d/${USER}" > /dev/null || exit 2
	echo ""

	## Parsing input:
	case ${1:-} in
		"" | -s | --start | start | --run | run)
			_doStart;;
			# shift;;
		-b | --bash | bash | /bin/bash)
			shift
			if [ -z "${*:-}" ]; then
				echo "[INFO]: Starting bash..."
				/bin/bash
			else
				echo "[INFO]: Executing command -> ${*}"
				exec /bin/bash -c "${@}" || exit 2
			fi
			exit 0;;
		*)
			echo "[ERROR]: Failed to parsing input -> ${*}"
			echo "[INFO]: USAGE: ${0}  -s, --start, start | -b, --bash, bash, /bin/bash"
			exit 1;;
	esac
}

main "${@:-}"
