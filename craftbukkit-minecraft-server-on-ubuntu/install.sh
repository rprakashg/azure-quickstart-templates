#!/bin/sh
# $1 = Minecraft user 
# $2 = difficulty
# $3 = level-name
# $4 = gamemode
# $5 = white-list
# $6 = enable-command-block
# $7 = max-players
# $8 = allow-flight
# $9 = spawn-protection
# $10 = spawn-monsters
# $11 = generate-structures
# $12 = level-seed

# add update repository
while ! echo y | apt-get install -y software-properties-common; do
    sleep 10
    apt-get install -y software-properties-common
done

while ! echo y | apt-add-repository -y ppa:webupd8team/java; do
    sleep 10
    apt-add-repository -y ppa:webupd8team/java
done

while ! echo y | apt-get update; do
    sleep 10
    apt-get update
done

# Install Java8
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

while ! echo y | apt-get install -y oracle-java8-installer; do
    sleep 10
    apt-get install -y oracle-java8-installer
done

#install git
while ! echo y | apt-get install -y git; do
	sleep 10
	apt-get install -y git
done

adduser --system --no-create-home --home /srv/bukkit-minecraft-server minecraftadmin
addgroup --system minecraftadmins
adduser minecraftadmin minecraftadmins
mkdir /srv/bukkit-minecraft-server
cd /srv/bukkit-minecraft-server

#download last successful buildtools.jar from spigotmc build server
while ! echo y | wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar; do
	sleep 10
	wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -O BuildTools.jar
done

#set permissions on install dir
chown -R minecraftadmin /srv/bukkit-minecraft-server

#Run buildtools
java -jar BuildTools.jar --rev 1.8.8

#clean up directory
find . -maxdepth 1 -not -name "*.jar" -delete;

mallocSize=1024m

#create service
touch /etc/systemd/system/bukkit-minecraft-server.service
echo '[Unit]\nDescription=Bukkit Minecraft Service\nAfter=rc-local.service\n' >> /etc/systemd/system/bukkit-minecraft-server.service
echo '[Service]\nWorkingDirectory=/srv/bukkit-minecraft-server' >> /etc/systemd/system/bukkit-minecraft-server.service
printf 'ExecStart=/usr/bin/java -Xms%s -Xmx%s -jar /srv/bukkit-minecraft-server/craftbukkit-1.8.8.jar nogui' $mallocSize $mallocSize >> /etc/systemd/system/bukkit-minecraft-server.service
echo 'ExecReload=/bin/kill -HUP $MAINPID\nKillMode=process\nRestart=on-failure\n' >> /etc/systemd/system/bukkit-minecraft-server.service
echo '[Install]\nWantedBy=multi-user.target\nAlias=bukkit-minecraft-server.service' >> /etc/systemd/system/bukkit-minecraft-server.service

#create and set permissions on user access JSON files
touch /srv/bukkit-minecraft-server/banned-players.json
chown minecraftadmin:minecraftadmins /srv/bukkit-minecraft-server/banned-players.json
touch /srv/bukkit-minecraft-server/banned-ips.json
chown minecraftadmin:minecraftadmins /srv/bukkit-minecraft-server/banned-ips.json
touch /srv/bukkit-minecraft-server/whitelist.json
chown minecraftadmin:minecraftadmins /srv/bukkit-minecraft-server/whitelist.json

#op the minecraft user
touch /srv/bukkit-minecraft-server/ops.json
chown minecraftadmin:minecraftadmins /srv/bukkit-minecraft-server/ops.json
UUID="`wget -q  -O - http://api.ketrwu.de/$1/`"
sh -c "echo '[\n {\n  \"uuid\":\"$UUID\",\n  \"name\":\"$1\",\n  \"level\":4\n }\n]' >> /srv/bukkit-minecraft-server/ops.json"

#set user preferences in server.properties
touch /srv/bukkit-minecraft-server/server.properties
chown minecraftadmin:minecraftadmins /srv/bukkit-minecraft-server/server.properties

sh -c "echo 'difficulty=$2' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'level-name=$3' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'gamemode=$4' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'white-list=$5' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'enable-command-block=$6' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'max-players=$7' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'allow-flight=$8' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'spawn-protection=$9' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'spawn-monsters=$10' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'generate-structures=$11' >> /srv/bukkit-minecraft-server/server.properties"
sh -c "echo 'level-seed=$12' >> /srv/bukkit-minecraft-server/server.properties"

#finally create the eula file
touch /srv/bukkit-minecraft-server/eula.txt
echo 'eula=true' >> /srv/bukkit-minecraft-server/eula.txt

#start the server
systemctl start bukkit-minecraft-server