# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/DotOS/manifest -b dot12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/abhishekhembrom08/manifest_local.git --depth 1 -b dotosGinkgo .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
#export SELINUX_IGNORE_NEVERALLOWS=true
#export ALLOW_MISSING_DEPENDENCIES=true
lunch dot_ginkgo-userdebug
export KBUILD_BUILD_USER=xyz_abhishek
export KBUILD_BUILD_HOST=xyz_abhishek
export BUILD_USERNAME=xyz_abhishek
export BUILD_HOSTNAME=xyz_abhishek
export TZ=Asia/Kolkata #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/recovery.img cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P


#fck_Alone0316_madarchod_nahi_sudhrega
#HavocBhiMadarchodNikla
#LagtaHaiDotOSviMadarChodNiklega

#backup
