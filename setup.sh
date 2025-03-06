#!/bin/sh
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
else
  cp $PWD/update-system.service 	/etc/systemd/system/update-system.service
  cp $PWD/update-system.time 	/etc/systemd/system/update-system.time
  cp $PWD/lazydeb.sh		$HOME/.lazydeb.sh
  systemctl --system enable --now update-system.time
  echo "all done, you may reboot your system now"
fi


