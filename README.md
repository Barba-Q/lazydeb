# lazydeb
A systemd service with a hackable script to completely automate software- and flatpak updates for debian


The systemd service will execute the lazydeb.sh on every system boot.

## What it does
- Install flatpak functionality and make flatpaks available for gnome-software
- Update software
- Cleanup unneeded, obsolete and orphaned packages
- Update flatpaks
- Cleanup unneeded, obsolete and orphaned flatpaks
- Upgrade Debian Version (will only work if the "debianversionname" in sources.list is changed to "stable" - and a newer debian version is available of course)
- Set IP range (this is not necessary for the most but it helps with some multiplayer games so its in, remove it if you don't want it)
- Write a log

## How to install
- Download repository
- run setup.sh as root
- reboot the system and never think about software updates again

## How to use
- Once all files are in place, everything will work automatically, you may check /var/log/updatescript.log to make sure the script works.

## Troubleshoot
- Check the logfile for errors
- If no logfile appears at all make sure $HOME/.lazydeb.sh is in place and executeable.
- Execute $HOME/.lazydeb.sh by hand and see what the terminal spits out for further troubleshoot.

## Known issue
- It may happen that a kernel- or a specific flatpak update will make a piece of software (Steam e.g) unusable. This is normal behaviour especially when you're utilizing dmks nvidia drivers. Just reboot your system to fix this. In the future there will be a graphical notification when such packages are updated by the script.
