#!/bin/bash
WORKSPACE=~/twrp
TWRP_SOURCE=git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git
TWRP_BRANCH=twrp-8.1
DEVICE_CODE=
export DEVICE_CODE
DEVICE_MANUFACTURER=
export DEVICE_CODE
DEVICE_SOURCE=
DT_DIR=device/$DEVICE_MANUFACTURER/$DEVICE_CODE
GIT_USER_NANE=
GIT_USER_EMAIL=
GIT_COLOR_UI=false
###################################################################################
git config --global user.name $GIT_USER_NANE
git config --global user.email $GIT_USER_EMAIL
git config --global color.ui $GIT_COLOR_UI

java -version
update-java-alternatives

if [ ! -d ~/bin ]; then
    echo "[I] Setting up repo !"
    mkdir ~/bin
fi

PATH=~/bin:$PATH
source ~/.bashrc
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

if [ ! -d $WORKSPACE ]; then
    echo "[I] Setting up TWRP source !"
    mkdir -p $WORKSPACE
fi

cd $WORKSPACE
repo init --depth=1 -u $TWRP_SOURCE -b $TWRP_BRANCH
repo sync >log 2>&1

if [ ! -d $DT_DIR ]; then
    echo "[I] Setting up device tree !"
    mkdir -p $DT_DIR
    git clone $DEVICE_SOURCE $DT_DIR
fi
echo "[I] Preparing for build !"
export ALLOW_MISSING_DEPENDENCIES=true
export USE_CCACHE=1
source build/envsetup.sh
lunch omni_$DEVICE_CODE-eng
echo "[I] Build started !"
mka recoveryimage