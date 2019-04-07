#!/bin/bash
set -x

# This script rsync's most of home into corresponding folders in svalbard
if [ -z $1 ] ; then
  folder="svalbard"
else
  folder=$1
fi

rcl() {
  rclone -L --stats 5s --stats-log-level NOTICE $@
}

rcl copy ~/Music ~/$folder/Music
rcl copy ~/Videos ~/$folder/Videos
rcl copy ~/Downloads ~/$folder/Downloads
rcl copy ~/Pictures ~/$folder/Pictures
rcl copy ~/Documents ~/$folder/Documents
rcl copy ~/work ~/linux/work
rcl copy ~/git ~/linux/git
rcl copy ~/temp ~/linux/temp
echo "Finished backing up"
