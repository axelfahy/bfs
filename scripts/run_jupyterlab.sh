#!/bin/bash -
#===============================================================================
#
#          FILE: run_jupyterlab.sh
#
#         USAGE: ./run_jupyterlab.sh
#
#   DESCRIPTION: Script to start JupyterLab  on a server
#                and display the right url, that is the one with the hostname
#                of the server and the correct port used.
#
#                The script tries to find an available port starting from 8888.
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Axel Fahy (axel@fahy.net),
#  ORGANIZATION:
#       CREATED: 01.05.19 15:07
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error.

declare -r HOST=`hostname`

# Check if jupyterlab is installed.
if ! python -c 'import pkgutil; exit(not pkgutil.find_loader("jupyterlab"))'; then
    echo -e "Package jupyterlab is not installed or virtual environment is not activated. Aborting." 1>&2
    exit 1
fi

echo -e "Possible Jupyter binaries: $(whereis jupyter)"
echo -e "Using Jupyter from $(which jupyter)"

echo -e "Looking for an available port..."

declare port=8888

for i in $(seq $port 8950); do
    # Check if the port is already used.
    echo -e "Checking port: $i"
    ss -tlnp | grep -q $i &> /dev/null
    if [ $? -ne 0 ]; then
        port=$i
        echo -e "Using port: $port"
        break
    fi
done

jupyter lab --ip=0.0.0.0 --no-browser --NotebookApp.port=$port --NotebookApp.custom_display_url=http://$HOST:$port

