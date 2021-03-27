# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=joyeuse
device.name2=curtana
device.name3=excalibur
device.name4=gram
device.name5=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod -R 755 $ramdisk/sbin;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# end ramdisk changes

# Uclamp tunables
if [ -f /dev/cpuset/top-app/uclamp.max ]; then
	ui_print "  • Uclamp supported kernel"
	#Uclamp tuning
	sysctl -w kernel.sched_util_clamp_min_rt_default=96
	sysctl -w kernel.sched_util_clamp_min=128

	#top-app
	echo max > /dev/cpuset/top-app/uclamp.max
	echo 10  > /dev/cpuset/top-app/uclamp.min
	echo 1   > /dev/cpuset/top-app/uclamp.boosted
	echo 1   > /dev/cpuset/top-app/uclamp.latency_sensitive

	#foreground
	echo 50 > /dev/cpuset/foreground/uclamp.max
	echo 0  > /dev/cpuset/foreground/uclamp.min
	echo 0  > /dev/cpuset/foreground/uclamp.boosted
	echo 0  > /dev/cpuset/foreground/uclamp.latency_sensitive

	#background
	echo max > /dev/cpuset/background/uclamp.max
	echo 20  > /dev/cpuset/background/uclamp.min
	echo 0   > /dev/cpuset/background/uclamp.boosted
	echo 0   > /dev/cpuset/background/uclamp.latency_sensitive

	#system-background
	echo 40 > /dev/cpuset/system-background/uclamp.max
	echo 0  > /dev/cpuset/system-background/uclamp.min
	echo 0  > /dev/cpuset/system-background/uclamp.boosted
	echo 0  > /dev/cpuset/system-background/uclamp.latency_sensitive

fi

write_boot;
## end install
