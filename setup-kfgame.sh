# Setup KFGame.ini
CONFIG_FILE="./KFGame/Config/LinuxServer-KFGame.ini"


sed -i -e "s~^ServerName=.*~ServerName=(Maylife Server)~g" "${CONFIG_FILE}"
sed -i -e "s~^ShortName=.*~ShortName=$SHORT_NAME~g" "${CONFIG_FILE}"
sed -i -e "s~^WebsiteLink=.*~WebsiteLink=$WEBSITE_LINK~g" "${CONFIG_FILE}"
sed -i -e "s~^BannerLink=.*~BannerLink=$BANNER_LINK~g" "${CONFIG_FILE}"
sed -i -e "s~^ServerMOTD=.*~ServerMOTD=$SERVER_MOTD~g" "${CONFIG_FILE}"
sed -i -e "s~^ClanMotto=.*~ServerMOTD=$CLAN_MOTTO~g" "${CONFIG_FILE}"


sed -i -e "s~^AdminPassword=.*~AdminPassword=$ADMIN_PASSWORD~g" "${CONFIG_FILE}"
sed -i -e "s~^GamePassword=.*~$GAME_PASSWORD~g" "${CONFIG_FILE}"