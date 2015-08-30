# hardcore-minecraft
Helper scripts for managing minecraft servers that need to be reset often.

## Reset world
When configured, this is the primary script you'll want to deal with for 
your hardcore world management. 

Running `reset.sh` will do the following:
1. Stop any existing screen session with the sockname 'minecraft'
2. Create a backup of your instance (if needed)
  * Creates a timestamped directory for your old server
  * Compresses the server to a tar.gz file
  * Creates a symlinked directory with a version number
3. Clears the old files
4. Copies a fresh server into place
5. Starts a new detached screen session running LaunchServer.sh

You should now have a fresh (loading) server in place of your old one.

## Setup
1. Run `setup.sh`
  * This creates the necessary directory structure
  * It will also attempt to install screen
2. Put your server into fresh-files/ directory
3. Make sure your server is ready to go
  * Make sure the minecraft EULA is accepted beforehand
  * Configure your server.properties the way you want it
  * Make sure the fresh-files doesn't have any state data (world, saves)
4. Start your first world by running `reset.sh`
