#!/bin/bash

SERVER_NAME="$SERVER_NAME"
SHORT_NAME="$SHORT_NAME"
WEBSITE_LINK="$WEBSITE_LINK"
BANNER_LINK="$BANNER_LINK"
SERVER_MOTD="$SERVER_MOTD"
CLAN_MOTTO="$CLAN_MOTTO"
ADMIN_PASSWORD="$ADMIN_PASSWORD"
GAME_PASSWORD="$GAME_PASSWORD"

CONFIG_FILE=./KFGame/Config/LinuxServer-KFGame.ini

sed -i -e "s~^ServerName=.*~ServerName=$SERVER_NAME~g" "$CONFIG_FILE"
sed -i -e "s~^ShortName=.*~ShortName=$SHORT_NAME~g" "$CONFIG_FILE"
sed -i -e "s~^WebsiteLink=.*~WebsiteLink=$WEBSITE_LINK~g" "$CONFIG_FILE"
sed -i -e "s~^BannerLink=.*~BannerLink=$BANNER_LINK~g" "$CONFIG_FILE"
sed -i -e "s~^ServerMOTD=.*~ServerMOTD=$SERVER_MOTD~g" "$CONFIG_FILE"
sed -i -e "s~^ClanMotto=.*~ClanMotto=$CLAN_MOTTO~g" "$CONFIG_FILE"

sed -i -e "s~^AdminPassword=.*~AdminPassword=$ADMIN_PASSWORD~g" "$CONFIG_FILE"
sed -i -e "s~^GamePassword=.*~$GAME_PASSWORD~g" "$CONFIG_FILE"


# Launch new game or the last played map
MAPVOTE=$(awk '/MapVote/ {last=$0} END {print last}' ./KFGame/Logs/Launch.log | sed 's~.*MapVote: Switch map to ~~')
if [[ -z "$MAPVOTE" ]] ; then
    MAP=$(cat $CONFIG_FILE | grep "MapName=" | sed 's~MapName=~~'| shuf -n 1)
    ./Binaries/Win64/KFGameSteamServer.bin.x86_64 $MAP?Difficulty=2?UnsuppressLogs=1?Mutator=UnofficialKFPatch.UKFPMutator
else
    ./Binaries/Win64/KFGameSteamServer.bin.x86_64 $MAPVOTE
fi
