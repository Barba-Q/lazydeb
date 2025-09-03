# lazydeb
A script to fully automate system and Flatpak updates on Debian-based systems. Ensures contrib & non-free are enabled and installs Flatpak if needed.

## What it does
- Install flatpak functionality and make flatpaks available
- Update software via unattended upgrades
- Cleanup unneeded, obsolete and orphaned packages
- Update flatpaks
- Cleanup unneeded, obsolete and orphaned flatpaks
- Write a log

## How to install
- Download repository
- run lazydeb.sh as root
- reboot the system and never think about software updates again

## How to use
- Once setup is done, everything will work automatically, you may check /var/log/ every now and then

## Troubleshoot
- Check the logfile for errors
- If no logfile appears at all make sure $HOME/.lazydeb.sh is in place and executeable.

