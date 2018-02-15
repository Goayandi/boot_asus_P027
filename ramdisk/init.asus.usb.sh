#!/bin/sh
# ASUS-BSP Note: move up before any adbd being called
ls_ssn=`ls /persist/SSN`
case "$ls_ssn" in
		*SSN*)
			ssn_value=`cat /persist/SSN`
			echo "$ssn_value" > /sys/class/android_usb/android0/iSerial
		;;
		* )
			echo "111111111111111" > /sys/class/android_usb/android0/iSerial
		;;
esac
