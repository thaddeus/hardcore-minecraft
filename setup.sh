#!/bin/bash
echo "## Creating new minecraft-hardcore installation"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Create directories
echo "# Creating directories"
mkdir ${DIR}/current-server
mkdir ${DIR}/fresh-files
mkdir ${DIR}/old-servers
mkdir ${DIR}/old-servers/servers
