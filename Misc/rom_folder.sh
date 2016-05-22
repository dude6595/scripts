#!/bin/bash

# Usage: this is a source start over script; will remove the previous folder, create a new one, and, if requested, it will sync the source again
# . rom_folder.sh <rom> <sync|nosync>

# Parameters:
# Parameter 1: the ROM, possible values include du|pnlayers|pncmte|aicp|temasek|aosip|screwd
# Parameter 2: whether or not to sync the repo right away
ROM=${1}
SYNC=${2}

# Parent directory of source
ROM_DIR=~/ROMs

# Define the name of the source directory as well as the repo URL and the repo branch to sync
if [ "${ROM}" == "du"]
then
   SOURCE_DIR=${ROM_DIR}/DU
   REPO_URL=http://github.com/DirtyUnicorns/android_manifest.git
   REPO_BRANCH=m
elif [ "${ROM}" == "pnlayers"]
then
   SOURCE_DIR=${ROM_DIR}/PN-Layers
   REPO_URL=https://github.com/PureNexusProject/manifest.git
   REPO_BRANCH=mm
elif [ "${ROM}" == "pncmte"]
then
   SOURCE_DIR=${ROM_DIR}/PN-CMTE
   REPO_URL=https://github.com/PureNexusProject/manifest.git
   REPO_BRANCH=mm-cmte
elif [ "${ROM}" == "aicp"]
then
   SOURCE_DIR=${ROM_DIR}/AICP
   REPO_URL=https://github.com/AICP/platform_manifest.git
   REPO_BRANCH=mm6.0
elif [ "${ROM}" == "temasek"]
then
   SOURCE_DIR=${ROM_DIR}/Temasek
   REPO_URL=https://github.com/temasek/android.git
   REPO_BRANCH=cm-13.0
elif [ "${ROM}" == "aosip"]
then
   SOURCE_DIR=${ROM_DIR}/AOSiP
   REPO_URL=https://github.com/AOSIP/platform_manifest.git
   REPO_BRANCH=mm6.0
elif [ "${ROM}" == "screwd"]
then
   SOURCE_DIR=${ROM_DIR}/Screwd
   REPO_URL=https://github.com/ScrewdAOSP/platform_manifest.git
   REPO_BRANCH=m
fi

# Remove the previous directory and create a new one
rm -rf ${SOURCE_DIR} && mkdir ${SOURCE_DIR}
echo -e "Removed previous direcotry and created a new one" | tr [a-z] [A-Z]

# Sync the source if requested
if [ "$SYNC" == "sync" ]
then
   echo -e "Syncing repo" | tr [a-z] [A-Z]

   # run the repo command
   repo init -u ${REPO_URL} -b ${REPO_BRANCH} && repo sync --force-sync

   # Sync dependencies
   cd ${SOURCE_DIR}
   . build/envsetup.sh
   breakfast angler
   breakfast bullhead
   breakfast hammerhead
   breakfast shamu
fi