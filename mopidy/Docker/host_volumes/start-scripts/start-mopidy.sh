#!/bin/bash


# function mkfifoFile {
#   mkfifo -m 666 /dev/shm/snapfifo2
# }

# if [ -e /dev/shm/snapfifo2 ]; then
#   echo "/dev/shm/snapfifo2 exist"
#   rm /dev/shm/snapfifo2 > /dev/null 2>&1

#   # ls -l /dev/shm/
# else
#   echo "/dev/shm/snapfifo2 does not exist"
#   mkfifoFile
# fi

# echo
# echo "Container Running."
# echo "If started with 'docker-compose up' without detaching, press 'ctrl-c' to stop."
# echo "'docker-compose down' for pull down of container."

#ls -l /dev/shm/snapfifo

/usr/bin/mopidy

#tail -f /dev/null
exit 0
