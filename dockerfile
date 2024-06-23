FROM cm2network/steamcmd

ARG path=/kf2
ARG steamcmd=/home/steam/steamcmd/steamcmd.sh
# setup folder
USER root
RUN mkdir $path ; chown steam $path
WORKDIR $path
USER steam

# Install KF2 server and generate ini files
RUN $steamcmd +login anonymous +force_install_dir $path +app_update 232130 +quit
RUN ./Binaries/Win64/KFGameSteamServer.bin.x86_64 kf-bioticslab & sleep 5 ; exit 0
RUN sed -i -e 's~^bEnabled=.*~bEnabled=true~g' ./KFGame/Config/KFWeb.ini

# Install and setup workshop Items
COPY --chown=+x ./workshop_download.sh ./workshop_download.sh 
RUN ./workshop_download.sh

# Copy Config folder
COPY --chown=steam:steam ./KFGame/Config/ ./KFGame/Config/

# Setup KFGame.ini
ENV SERVER_NAME="Killing Floor 2 Server"
ENV SHORT_NAME="KFServer"
ENV WEBSITE_LINK="http://killingfloor2.com/"
ENV BANNER_LINK="http://art.tripwirecdn.com/TestItemIcons/MOTDServer.png"
ENV SERVER_MOTD="Welcome to our server. \n \n Have fun and good luck!"
ENV CLAN_MOTTO="This is the clan motto."
ENV ADMIN_PASSWORD=
ENV GAME_PASSWORD=
COPY --chown=+x ./setup-kfgame.sh ./setup-kfgame.sh

# Start Server
ENTRYPOINT ./setup-kfgame.sh ; ./Binaries/Win64/KFGameSteamServer.bin.x86_64 kf-bioticslab?Difficulty=1?Mutator=UnofficialKFPatch.UKFPMutator


# Notes Start
  # https://wiki.killingfloor2.com/index.php?title=Dedicated_Server_(Killing_Floor_2)
  # https://steamcommunity.com/sharedfiles/filedetails/?id=1223901403
  # https://steamcommunity.com/sharedfiles/filedetails/?id=1110775580
  # https://steamcommunity.com/sharedfiles/filedetails/?id=2875577642
  # https://steamcommunity.com/sharedfiles/filedetails/?id=2802357098