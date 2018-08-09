#!/bin/sh

echo "================================================="
echo "          Welcome to the"
echo "  Docker In Docker Automatic Installer"
echo "      scripted by Sergio Rivas"
echo "================================================="
echo ""
echo "       .--.__"
echo "     .~ (@)  ~~~---_"
echo "    {     \`-_~,,,,,,)   ____________________"
echo "    {    (_  ',        /  Docker In Docker! \\"
echo "     ~    . = _',     <                      |"
echo "      ~-   '.  =-'     \\ Which one you want? |"
echo "        ~     :         \\ Mediawiki? Piwik?  |"
echo "   _,.-~     ('');       \\ or Wordpress?    / "
echo ".-~        \  \ ;         \\________________/"
echo "~            \  \;      _-=,."
echo "            {  '---- _'-=,."
echo "            ~---------=,.\`"
echo "           /"
echo "         _/"
echo "_______.~"
echo ""
echo ""
echo " ================================"
echo " |    m = Mediawiki  p = Piwik   |"
echo " |          w = Wordpress        |"
echo " |                               |"
echo " |   NOTE: If you want to use    |"
echo " |  many containers together,    |"
echo " | Please Install in this order: |"
echo " | Piwik, Wordpress, Mediawiki   |"
echo " ================================="
echo ""
echo ""

# Get container choice
choice=""
while [[ "$choice" != "m" && "$choice" != "p" && "$choice" != "w" ]]
do
  echo "Please make your choice. m, p, or w?"
  read choice
done
echo ""

# Name container
name=""
while [[ "$name" = "" ]]
do
  echo "Please name your container"
  read name

  # Check if container exists
  if [[ $(docker ps --filter "name=^/$name$" --format '{{.Names}}') == $name ]]; then
    echo "container with that name exists!"
    name=""
  fi
done
echo ""

# Select port for container
port=""
while [[ "$port" = "" ]]
do
  echo "Which port for your container?"
  read port

  # Check if port used
  if [[ ! -z $(lsof -Pni | grep $port) ]]; then
    echo "container with that port exists!"
    port=""
  fi
done
echo ""


if [[ $choice = "m" ]]; then
  echo ""
  echo "Now Launching Mediawiki RAWR!!"
  echo "                   __"
  echo "                 / *_) ?"
  echo "      _.----. _ /../"
  echo "    /............./"
  echo "__/..(...|.(...|"
  echo "/__.-|_|--|_|"

  docker run \
    --name $name -p $port:4444 \
    -e DOCKER_DAEMON_ARGS="-D" -e PORT=4444 -e APP_NAME="mediawiki" \
    --privileged -d tuitu/dind-mediawiki:latest
  sleep 5
  docker exec -it $name bash /TensorCloud/DockerInDocker/mariadb_mediawiki_4444.sh
  echo "New Docker-In-Docker Container Launched!"
fi

if [[ $choice = "p" ]]; then
  echo ""
  echo "Now Launching Piwik RAWR!!"
  echo "             /\\"
  echo "           /\\  /\\"
  echo "       /\\/\\      /\\"
  echo " |||..^            ^^o"
  echo " ------__\\ /---\\ /--~"
  echo "          | |    ||"
  echo "          --*    -*"

  docker run \
    --name $name -p $port:4446 \
    -e DOCKER_DAEMON_ARGS="-D" -e PORT=4446 -e APP_NAME="piwik" \
    --privileged -d tuitu/dind-piwik:latest
  sleep 5
  docker exec -it $name bash /TensorCloud/DockerInDocker/mariadb_piwik_4446.sh
  echo "New Docker-In-Docker Container Launched!"
fi

if [[ $choice = "w" ]]; then
  echo ""
  echo "Now Launching Wordpress RAWR!!"
  echo "       __"
  echo "      /oo\\"
  echo "     |    |"
  echo " ^^  (vvvv)   ^^"
  echo " \\\\  /\\__/\\  //"
  echo "  \\\\/      \\//"
  echo "   /        \\        "
  echo "  |          |    ^  "
  echo "  /          \\___/ | "
  echo " (            )     |"
  echo "  \\----------/     /"
  echo "    //    \\\\_____/"
  echo "   W       W"

  docker run \
    --name $name -p $port:4445 \
    -e DOCKER_DAEMON_ARGS="-D" -e PORT=4445 -e APP_NAME="wordpress" \
    --privileged -d tuitu/dind-wordpress:latest
  sleep 5
  docker exec -it $name bash /TensorCloud/DockerInDocker/mariadb_wordpress_4445.sh
  echo "New Docker-In-Docker Container Launched!"
fi

