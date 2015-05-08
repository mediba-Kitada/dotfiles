#!/bin/sh

usbEthEnabledPattern='9'
wifiDeviceName='en0'

_info=`/usr/sbin/networksetup -getinfo 'USB Ethernet' | /usr/local/opt/coreutils/libexec/gnubin/wc -l`
case $_info in
	$usbEthEnabledPattern) /usr/sbin/networksetup -setairportpower $wifiDeviceName off;;
	*) /usr/sbin/networksetup -setairportpower $wifiDeviceName on;;
esac

