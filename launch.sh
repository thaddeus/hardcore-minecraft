#!/bin/bash
echo "### Initializing"
# Current directory
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# Current PWD
STARTING_PWD=$PWD

echo "### Finding server files"
echo "# Attempting to launch current server"
if [[ -e "${DIR}/current-server/LaunchServer.sh" ]]; then
    echo "Found launch script."
    launch_path="${DIR}/current-server"
else
    echo "Launch script not found. Exiting."
    exit 1
fi

echo "### Stopping previous instance"
# Check if the screen instance exists first
if screen -list | grep -q "minecraft"; then
    echo "# Found minecraft screen, quitting"
    screen -X -S minecraft quit
    while screen -list | grep -q "minecraft"
    do
        sleep 1
    done
else
    echo "# No screen found, skipping"
fi

echo "### Starting server"
cd ${launch_path}
screen -S minecraft -dm bash -c ./LaunchServer.sh
cd ${STARTING_PWD}

echo "### Done"
