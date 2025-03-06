#!/bin/sh
# Path to logfile
log=/var/log/updatescript.log
cdt=$(date)
echo "######## Commencing update $cdt" >> $log

# Function to check online status
check_online() {
    if nc -zw1 google.com 443; then
        return 0  # Online
    else
        return 1  # Offline
    fi
}

# Wait for online connection for up to 5 minutes (300 seconds)
echo "Checking for online connection..." >> $log
online=false
for i in $(seq 1 30); do  # 30 attempts, 10 seconds each
    if check_online; then
        online=true
        break
    else
        echo "Waiting for online connection... Attempt $i/30" >> $log
        sleep 10  # Wait 10 seconds before retrying
    fi
done

# If still offline, exit
if [ "$online" = false ]; then
    echo "System is offline after 5 minutes, skipping update script." >> $log
    exit 1
fi

# System is online, proceeding
echo "System is online, calling updatescript..." >> $log

# Perform first time setup
if dpkg -s flatpak &>/dev/null; then
  echo 'flatpak found, proceeding with updates'
else
  echo 'flatpak is missing, proceeding with initial setup'
  apt-get update
  apt-get -y install flatpak gnome-software-plugin-flatpak 
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo	  
fi

# Perform system updates
echo "1/2 Performing system update if necessary" >> $log
echo "updating sources:" >> $log
apt-get update >> $log || echo "apt-get update failed" >> $log
echo "updating software:" >> $log
apt-get -y upgrade >> $log || echo "apt-get upgrade failed" >> $log
echo "updating debian if possible:" >> $log
# This will only work if you have "stable" instead of "debianversionname" in your sources.list -> thats on you
apt-get -y dist-upgrade >> $log || echo "apt-get dist-upgrade failed" >> $log
echo "removing unnecessary stuff:" >> $log
apt -y autoremove >> $log || echo "apt autoremove failed" >> $log
sleep 2

# Perform flatpak updates
echo "2/2 Performing flatpak updates if possible" >> $log
flatpak update --assumeyes --noninteractive --system >> $log || echo "flatpak update failed" >> $log
echo "removing unnecessary flatpak stuff:" >> $log
flatpak uninstall --assumeyes --noninteractive --system --unused >> $log || echo "flatpak uninstall failed" >> $log
sleep 2

# Apply sysctl settings
echo "Applying sysctl settings..." >> $log
/sbin/sysctl -w net.ipv4.ping_group_range="0 2147483647" >> $log || echo "sysctl failed" >> $log

# Done
echo "All done, see you later :-)" >> $log
