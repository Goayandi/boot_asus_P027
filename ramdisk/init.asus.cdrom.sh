#!/bin/sh
# ASUS-BSP Note: move up before any adbd being called
#
# Add support for exposing lun0 as cdrom in mass-storage
#
cdromname="/system/etc/cdrom_install.iso"
per_sysusbconfig=`getprop persist.sys.usb.config`
if [ -f $cdromname ]; then
    setprop persist.service.cdrom.enable 1
    echo "mounting usbcdrom lun" > /dev/kmsg
    echo 1 > /sys/class/android_usb/android0/f_mass_storage/bicr
    echo $cdromname > /sys/class/android_usb/android0/f_mass_storage/lun/file
    chmod 0444 /sys/class/android_usb/android0/f_mass_storage/lun/file
    case "$per_sysusbconfig" in
	"mtp,adb")
		setprop persist.sys.usb.config mtp,adb,mass_storage
	;;
	"mtp")
		setprop persist.sys.usb.config mtp,mass_storage
	;;
    esac
else
    setprop persist.service.cdrom.enable 0
    echo "unmounting usbcdrom lun" > /dev/kmsg
    echo "" > /sys/class/android_usb/android0/f_mass_storage/lun/file
    case "$per_sysusbconfig" in
	"mtp,adb,mass_storage")
		setprop persist.sys.usb.config mtp,adb
	;;
	"mtp,mass_storage")
		setprop persist.sys.usb.config mtp
	;;
    esac
fi
