if [ ! -d ~/bin ]; then
    echo "[I] Creating OTA Directory !"
    mkdir ~/bin
fi
PATH=~/bin:$PATH
source ~/.bashrc
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name chankruze
git config --global user.email chakruze@gmail.com
mkdir ~/twrp && cd ~/twrp
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-8.1
repo sync
mkdir -p device/oukitel/k10
git clone https://github.com/N00bTree/android_device_oukitel_k10.git device/oukitel/k10/
export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh
lunch omni_k10-eng
mka recoveryimage
