FROM cm2network/steamcmd

# EXPOSE Ports
#EXPOSE 7777 
#EXPOSE 8080 
#EXPOSE 20560 
#EXPOSE 27015 
#EXPOSE 123 


# setup folder
USER root
RUN mkdir /kf2 ; chown steam /kf2
#USER steam

# Install KF Server
RUN ./steamcmd.sh +login anonymous +force_install_dir /kf2 +app_update 232130 +quit

WORKDIR /kf2
RUN chown -R root /kf2

# todo make files stable in git 
#RUN sed -i -e 's/*TARGET*/*Change*/g' hello.txt
RUN sed -i -e 's/bEnabled=false/bEnabled=true/g' KFGame/Config/DefaultWeb.ini
RUN sed -i -e 's/AdminPassword=/AdminPassword=123/g' KFGame/Config/DefaultGame.ini


# Start Server
ENTRYPOINT ./Binaries/Win64/KFGameSteamServer.bin.x86_64 kf-bioticslab




# Notes Start


  #docker run -it  steamcmd/steamcmd:latest +login anonymous +force_install_dir /data +app_update 232130 +quit

  # docker build -t kf .
  # docker run -it kf sleep 9999

  # docker compose up -d --build
  # docker compose down -v

  # https://wiki.killingfloor2.com/index.php?title=Dedicated_Server_(Killing_Floor_2)
  # https://steamcommunity.com/sharedfiles/filedetails/?id=1223901403
  # https://steamcommunity.com/sharedfiles/filedetails/?id=1110775580



# /kf2/KFGame/Config/DefaultGame.ini
# /kf2/KFGame/Config/KFGame.ini
# /kf2/KFGame/Config/DefaultWeb.ini
# /kf2/KFGame/Config/KFWeb.ini


# cat KFGame/Config/DefaultGame.ini