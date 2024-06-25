#!/bin/bash

ServerName="$ServerName"
ShortName="$ShortName"
WebsiteLink="$WebsiteLink"
BannerLink="$BannerLink"
ServerMOTD="$ServerMOTD"
ClanMotto="$ClanMotto"
AdminPassword="$AdminPassword"
GamePassword="$GamePassword"
bDisableTeamCollision="$bDisableTeamCollision"

CONFIG_FILE=./KFGame/Config/LinuxServer-KFGame.ini

sed -i -e "s~^ServerName=.*~ServerName=$ServerName~g" "$CONFIG_FILE"
sed -i -e "s~^ShortName=.*~ShortName=$ShortName~g" "$CONFIG_FILE"
sed -i -e "s~^WebsiteLink=.*~WebsiteLink=$WebsiteLink~g" "$CONFIG_FILE"
sed -i -e "s~^BannerLink=.*~BannerLink=$BannerLink~g" "$CONFIG_FILE"
sed -i -e "s~^ServerMOTD=.*~ServerMOTD=$ServerMOTD~g" "$CONFIG_FILE"
sed -i -e "s~^ClanMotto=.*~ClanMotto=$ClanMotto~g" "$CONFIG_FILE"

sed -i -e "s~^AdminPassword=.*~AdminPassword=$AdminPassword~g" "$CONFIG_FILE"
sed -i -e "s~^GamePassword=.*~GamePassword=$GamePassword~g" "$CONFIG_FILE"

sed -i -e "s~^bDisableTeamCollision=.*~bDisableTeamCollision=$bDisableTeamCollision~g" "$CONFIG_FILE"



# Launch new game or the last played map
MAPVOTE=$(awk '/MapVote/ {last=$0} END {print last}' ./KFGame/Logs/Launch.log | sed 's~.*MapVote: Switch map to ~~')
if [[ -z "$MAPVOTE" ]] ; then
    MAP=$(cat $CONFIG_FILE | grep "MapName=" | sed 's~MapName=~~'| shuf -n 1)
    ./Binaries/Win64/KFGameSteamServer.bin.x86_64 $MAP?Difficulty=2?UnsuppressLogs=1?Mutator=UnofficialKFPatch.UKFPMutator
else
    ./Binaries/Win64/KFGameSteamServer.bin.x86_64 $MAPVOTE
fi
