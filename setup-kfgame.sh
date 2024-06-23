#!/bin/bash

# Setup KFGame.ini
CONFIG_FILE="./KFGame/Config/LinuxServer-KFGame.ini"
SERVER_NAME="$SERVER_NAME"
SHORT_NAME="$SHORT_NAME"
WEBSITE_LINK="$WEBSITE_LINK"
BANNER_LINK="$BANNER_LINK"
SERVER_MOTD="$SERVER_MOTD"
CLAN_MOTTO="$CLAN_MOTTO"
ADMIN_PASSWORD="$ADMIN_PASSWORD"
GAME_PASSWORD="$GAME_PASSWORD"


sed -i -e "s~^ServerName=.*~ServerName=$SERVER_NAME~g" "${CONFIG_FILE}"
sed -i -e "s~^ShortName=.*~ShortName=$SHORT_NAME~g" "${CONFIG_FILE}"
sed -i -e "s~^WebsiteLink=.*~WebsiteLink=$WEBSITE_LINK~g" "${CONFIG_FILE}"
sed -i -e "s~^BannerLink=.*~BannerLink=$BANNER_LINK~g" "${CONFIG_FILE}"
sed -i -e "s~^ServerMOTD=.*~ServerMOTD=$SERVER_MOTD~g" "${CONFIG_FILE}"
sed -i -e "s~^ClanMotto=.*~ServerMOTD=$CLAN_MOTTO~g" "${CONFIG_FILE}"


sed -i -e "s~^AdminPassword=.*~AdminPassword=$ADMIN_PASSWORD~g" "${CONFIG_FILE}"
sed -i -e "s~^GamePassword=.*~$GAME_PASSWORD~g" "${CONFIG_FILE}"