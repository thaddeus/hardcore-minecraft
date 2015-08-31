#!/bin/bash
echo "### Initializing"
# Current directory
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# Backup directory
BACKUP_DIR=${DIR}/old-servers/servers/`date +%Y%m%d_%H%M%S`
# Current PWD
STARTING_PWD=$PWD
# Move to current-server directory to do most of our work
cd ${DIR}/current-server/

echo "### Stopping previous instance"
# Check if the screen instance exists first
if ! screen -list | grep -q "minecraft"; then
    screen -X -S minecraft quit
fi

echo "### Backing up server"
if [ "$(ls -A $PWD)" ]; then
    echo "# Creating backup directory ${BACKUP_DIR}"
    mkdir ${BACKUP_DIR}
    echo "# Compressing old server"
    tar -zcvf server.tar.gz *
    echo "# Moving backup"
    mv ${DIR}/current-server/server.tar.gz ${BACKUP_DIR}
    echo "# Clearing old files"
    rm -r *
    echo "# Creating user friendly symlink"
    SERVER_COUNT=1
    while [[ -d "${DIR}/old-servers/server${SERVER_COUNT}" ]] ; do
        ((SERVER_COUNT+=1))
    done
    ln -s ${BACKUP_DIR} ${DIR}/old-servers/server${SERVER_COUNT}
    echo "Created symlink server${SERVER_COUNT}"
else
    echo "No files to back up, skipping.."
fi

echo "### Copying fresh server files into place"
cp ${DIR}/fresh-files/* ${DIR}/current-server -r

echo "### Starting server"
screen -S minecraft -dm bash -c ./LaunchServer.sh
cd ${STARTING_PWD}

echo "### Done"
