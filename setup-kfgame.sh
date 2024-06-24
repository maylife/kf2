#!/bin/bash

ServerName="$ServerName"
ShortName="$ShortName"
WebsiteLink="$WebsiteLink"
BannerLink="$BannerLink"
ServerMOTD="$ServerMOTD"
ClanMotto="$ClanMotto"
AdminPassword="$AdminPassword"
GamePassword="$GamePassword"
bDisableTeamCollision="bDisableTeamCollision"
Config=./KFGame/Config/LinuxServer-KFGame.ini

sed -i -e "s~^ServerName=.*~ServerName=$ServerName~g" "$Config"
sed -i -e "s~^ShortName=.*~ShortName=$ShortName~g" "$Config"
sed -i -e "s~^WebsiteLink=.*~WebsiteLink=$WebsiteLink~g" "$Config"
sed -i -e "s~^BannerLink=.*~BannerLink=$BannerLink~g" "$Config"
sed -i -e "s~^ServerMOTD=.*~ServerMOTD=$ServerMOTD~g" "$Config"
sed -i -e "s~^ClanMotto=.*~ClanMotto=$ClanMotto~g" "$Config"

sed -i -e "s~^AdminPassword=.*~AdminPassword=$AdminPassword~g" "$Config"
sed -i -e "s~^GamePassword=.*~$GamePassword~g" "$Config"

sed -i -e "s~^bDisableTeamCollision=.*~bDisableTeamCollision=$bDisableTeamCollision~g" "$Config"



# Launch new game or the last played map
MapVote=$(awk '/MapVote/ {last=$0} END {print last}' ./KFGame/Logs/Launch.log | sed 's~.*MapVote: Switch map to ~~')
if [[ -z "$MapVote" ]] ; then
    Map=$(cat $Config | grep "MapName=" | sed 's~MapName=~~'| shuf -n 1)
    ./Binaries/Win64/KFGameSteamServer.bin.x86_64 $Map?Difficulty=2?UnsuppressLogs=1?Mutator=UnofficialKFPatch.UKFPMutator
else
    ./Binaries/Win64/KFGameSteamServer.bin.x86_64 $MapVote
fi
