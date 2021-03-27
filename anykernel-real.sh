# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Scape
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=joyeuse
device.name2=curtana
device.name3=excalibur
device.name4=gram
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/platform/soc/c0c4000.sdhci/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 755 755 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;

# begin ramdisk changes

#Remove old kernel stuffs from ramdisk
ui_print "cleaning up..."
 rm -rf $ramdisk/init.special_power.sh
 rm -rf $ramdisk/init.darkonah.rc
 rm -rf $ramdisk/init.spectrum.rc
 rm -rf $ramdisk/init.spectrum.sh
 rm -rf $ramdisk/init.boost.rc
 rm -rf $ramdisk/init.trb.rc
 rm -rf $ramdisk/init.azure.rc
 rm -rf $ramdisk/init.PBH.rc
 rm -rf $ramdisk/init.Pbh.rc
 rm -rf $ramdisk/init.overdose.rc
 rm -rf $ramdisk/init.infinity.rc
 rm -rf $ramdisk/init.predator.rc
 rm -rf $ramdisk/init.error.rc
 rm -rf $ramdisk/init.venus.rc
 rm -rf $ramdisk/init.spectrum.rc

backup_file init.rc;
remove_line init.rc "import /init.darkonah.rc";
remove_line init.rc "import /init.spectrum.rc";
remove_line init.rc "import /init.boost.rc";
remove_line init.rc "import /init.trb.rc"
remove_line init.rc "import /init.azure.rc"
remove_line init.rc "import /init.PbH.rc"
remove_line init.rc "import /init.Pbh.rc"
remove_line init.rc "import /init.overdose.rc"
remove_line init.rc "import /init.infinity.rc"
remove_line init.rc "import /init.predator.rc"
remove_line init.rc "import /init.error.rc"
remove_line init.rc "import /init.venus.rc"
remove_line init.rc "import /init.spectrum.rc"

# Set Android version for kernel
ver="$(file_getprop /system/build.prop ro.build.version.release)"
if [ ! -z "$ver" ]; then
  patch_cmdline "androidboot.version" "androidboot.version=$ver"
else
  patch_cmdline "androidboot.version" ""
fi

# end ramdisk changes

write_boot;
## end install
