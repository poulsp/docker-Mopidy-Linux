# uname -m return x86_64 or armv6l or armv7l separate armv

# Determine mashice architechture

MACHINE=`uname -m`
#MACHINE=armv7l


if [[ $MACHINE == *"armv"* ]]; then
#   MACHINE=${MACHINE:0:4}
  ARCHITECTURE="Install Mopidy on armv architechture"
else
  ARCHITECTURE="Install Mopidy on "$MACHINE" architechture"

fi

echo $"$ARCHITECTURE"

#clear

START_TIME=`date +%s`

docker-compose down >/dev/null 2>&1

if [[ ! -e "./Docker/host_volumes/config/mopidy/mopidy.conf" ]];then
  NEW_INSTANCE="True"
  HOST_IP="`hostname -I |awk '{print $1}'`"
  cp ./Docker/host_volumes/examples/mopidy.conf.example  ./Docker/host_volumes/config/mopidy/mopidy.conf
  cp ./Docker/host_volumes/examples/Podcasts.opml.example ./Docker/host_volumes/config/mopidy/podcast/Podcasts.opml
  cp -a ./Docker/host_volumes/examples/playlist.examples/* ./Docker/host_volumes/data/mopidy/m3u/
  sed -i "s/tcpclientsink host=xx.xx.xx.xx port=4955/tcpclientsink host=$HOST_IP port\=4955/" ./Docker/host_volumes/config/mopidy/mopidy.conf
 fi

echo
USERID=`id -u $"$USER"`
GROUPID=`id -g $"$USER"`
echo $"Your USERID: $USERID"
echo $"Your GROUPID: $GROUPID"
echo

# -f for force build image
if [ "$1" == "-f" ];then
  BUILD_ARGS="--no-cache"
fi

#Is image builded
image=`docker image ls  -q psp/mopidy | cat -`
if [[  -z $image  ||  ! -z $BUILD_ARGS ]];then
  echo "Starter build"
  time docker build $BUILD_ARGS --force-rm --build-arg UID=$"$USERID" --build-arg GID=$"$GROUPID"  -t psp/mopidy -f Docker/Dockerfile .
fi

sleep 2

if [[ $NEW_INSTANCE == "True" ]];then
  # Start mopidy
  docker-compose up -d
  docker-compose exec mopidy bash -c 'bash /start-scripts/create_webinterfaces.sh'
  docker-compose down
fi

END_TIME=`date +%s`


echo ''
echo '  +-----------------------------------------------------------------------------------------------------------------+'
echo -e "  | \e[48;5;2m\e[38;5;228m                                             Docker mopidy                                                  \e[39m\e[49m    |"
echo '  |-----------------------------------------------------------------------------------------------------------------|'
echo -e '  |                                                                                                                 |'
echo "  | Creation of mopidy image finish!                                                                                |"
echo "  |                                                                                                                 |"
echo "  | The container are ready to use.                                                                                 |"
echo '  |-----------------------------------------------------------------------------------------------------------------|'
echo "  |                                                                                                                 |"
echo "  |  You can now run the container with:                                                                            |"
echo "  |    docker-compose up -d                                                                                         |"
echo "  |  And pull it down with:                                                                                         |"
echo "  |    docker-compose down                                                                                          |"
echo "  |                                                                                                                 |"
echo "  |  Or better use ./mopidy-start.sh and ./mopidy-stop.sh in this directory.                                        |"
echo "  |                                                                                                                 |"
echo "  |  Or make a symlink to the files in ~/bin. Then you can Start/Stop mopidy from everywhere.                       |"
echo "  |                                                                                                                 |"
echo "  |                                                                                                                 |"
echo "  |  The system is now at your service.                                                                             |"
echo "  |  Good luck!                                                                                                     |"
echo '  +-----------------------------------------------------------------------------------------------------------------+'
echo ''
echo ''

TOTAL_RUN_TIME="Built at "$(((END_TIME-START_TIME)/60))" minutes."
echo '--------------------------'
echo "$TOTAL_RUN_TIME"
echo '--------------------------'
