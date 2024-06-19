#!/bin/bash

path="$path"
steamcmd="$steamcmd"
# List of workshop IDs to download
workshop_ids=(
    # workshop - UnofficialKFPatch.UKFPMutator - https://steamcommunity.com/sharedfiles/filedetails/?id=2875147606
    "2875147606"
    # workshop - FriendlyHUD.FriendlyHUDMutator - https://steamcommunity.com/sharedfiles/filedetails/?id=1819268190 - FHUD + FHUDExt
    "1819268190"
    # workshop - Yet Another Scoreboard - https://steamcommunity.com/sharedfiles/filedetails/?id=2521826524&searchtext=Scoreboard - YAS
    "2521826524"
    # workshop - Admin Auto Login - https://steamcommunity.com/workshop/filedetails/?id=2848836389 - AAL
    "2848836389"
    # workshop - Controlled Vote Collector - https://steamcommunity.com/workshop/filedetails/?id=2847465899 - CVC
    "2847465899"
    # workshop - Looted Trader Inventory - https://steamcommunity.com/sharedfiles/filedetails/?id=2864857909 - LTI
    "2864857909"
)
# Download the workshop item
for id in "${workshop_ids[@]}"; do
    # Copy the downloaded files to the appropriate directories
    $steamcmd +login anonymous +force_install_dir $path/workshop_download +workshop_download_item 232090 $id +quit
    
    # Copy the files again to the Cache directory
    mkdir -p "./KFGame/Cache/$id/0/BrewedPC"    
    #cp -r ./workshop_download/steamapps/workshop/content/232090/$id/BrewedPC/* ./KFGame/BrewedPC
    cp -r ./workshop_download/steamapps/workshop/content/232090/$id/BrewedPC/* ./KFGame/Cache/$id/0/BrewedPC
done

# Remove the temporary workshop download directory
rm -d -r "./workshop_download"