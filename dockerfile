FROM cm2network/steamcmd

#EXPOSE Ports
#EXPOSE 7777 
#EXPOSE 8080 
#EXPOSE 20560 
#EXPOSE 27015 
#EXPOSE 123 
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
RUN sed -i -e 's~^bEnabled=.*~bEnabled=true~g' KFGame/Config/KFWeb.ini

# Install and setup workshop Items
COPY --chown=steam:steam ./Config/LinuxServer-KFEngine.ini ./KFGame/Config/LinuxServer-KFEngine.ini
COPY --chown=+x ./workshop_download.sh ./workshop_download.sh 
RUN ./workshop_download.sh

COPY --chown=steam:steam ./Config/KFUnofficialPatch.ini ./KFGame/Config/KFUnofficialPatch.ini
COPY --chown=steam:steam ./Config/KFxMapVote.ini ./KFGame/Config/KFxMapVote.ini
COPY --chown=steam:steam ./Config/KFYAS.ini ./KFGame/Config/KFYAS.ini
COPY --chown=steam:steam ./Config/KFAAL.ini ./KFGame/Config/KFAAL.ini
COPY --chown=steam:steam ./Config/KFCVC.ini ./KFGame/Config/KFCVC.ini
COPY --chown=steam:steam ./Config/KFLTI.ini ./KFGame/Config/KFLTI.ini



# todo make files stable in git 
#RUN sed -i -e 's/*TARGET*/*Change*/g' hello.txt
RUN sed -i -e 's/AdminPassword=/AdminPassword=123/g' KFGame/Config/DefaultGame.ini

COPY --chown=steam:steam ./Config/Web/ ./KFGame/Web/

# Start Server
ENTRYPOINT ./Binaries/Win64/KFGameSteamServer.bin.x86_64 kf-bioticslab?Difficulty=1?Mutator=UnofficialKFPatch.UKFPMutator


# Notes Start


  #docker run -it  steamcmd/steamcmd:latest +login anonymous +force_install_dir /data +app_update 232130 +quit

  # docker build -t kf .
  # docker run -it kf sleep 9999

  # docker compose up -d --build
  # docker compose down -v

  # https://wiki.killingfloor2.com/index.php?title=Dedicated_Server_(Killing_Floor_2)
  # https://steamcommunity.com/sharedfiles/filedetails/?id=1223901403
  # https://steamcommunity.com/sharedfiles/filedetails/?id=1110775580
  # https://steamcommunity.com/sharedfiles/filedetails/?id=2875577642
  # https://steamcommunity.com/sharedfiles/filedetails/?id=2802357098