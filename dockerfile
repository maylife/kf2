FROM cm2network/steamcmd

ARG WORKDIR=/home/steam/kf2
ARG steamcmd=/home/steam/steamcmd/steamcmd.sh
# setup folder
WORKDIR $WORKDIR
USER steam

# Install KF2 server and generate ini files
RUN $steamcmd +login anonymous +force_install_dir $WORKDIR +app_update 232130 +quit
RUN ./Binaries/Win64/KFGameSteamServer.bin.x86_64 kf-bioticslab & sleep 5 ; exit 0
RUN sed -i -e 's~^bEnabled=.*~bEnabled=True~g' ./KFGame/Config/KFWeb.ini

# Install and setup workshop Items
COPY --chown=+x ./workshop_download.sh ./workshop_download.sh 
RUN ./workshop_download.sh

# Copy changes KFGame folder
COPY --chown=steam:steam ./KFGame/ ./KFGame/

# Setup KFGame.ini
ENV ServerName="Killing Floor 2 Server"
ENV ShortName="KFServer"
ENV WebsiteLink="http://killingfloor2.com/"
ENV BannerLink="http://art.tripwirecdn.com/TestItemIcons/MOTDServer.png"
ENV ServerMOTD="Welcome to our server. \n \n Have fun and good luck!"
ENV ClanMotto="This is the clan motto."
ENV AdminPassword=
ENV GamePassword=
ENV bDisableTeamCollision=True

COPY --chown=+x ./setup-kfgame.sh ./setup-kfgame.sh

# Start Server
ENTRYPOINT ./setup-kfgame.sh


# Notes Start
  # https://wiki.killingfloor2.com/index.php?title=Dedicated_Server_(Killing_Floor_2)
  # https://steamcommunity.com/sharedfiles/filedetails/?id=1223901403
  # https://steamcommunity.com/sharedfiles/filedetails/?id=1110775580
  # https://steamcommunity.com/sharedfiles/filedetails/?id=2875577642
  # https://steamcommunity.com/sharedfiles/filedetails/?id=2802357098