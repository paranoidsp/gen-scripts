#!/bin/bash
set -x

# This script rsync's most of home into corresponding folders in svalbard
if [ -z $1 ] ; then
  folder="svalbard"
else
  folder=$1
fi

rcl() {
  rsync --partial --info=progress2 --log-file=/tmp/rsync-`date -Idate`.log --append --copy-links --rsh=ssh -rLg -h --exclude node_modules/  $@
}

rcl ~/Music ~/$folder
rcl ~/Videos ~/$folder
rcl ~/Downloads ~/$folder
rcl ~/Pictures ~/$folder
rcl ~/Documents ~/$folder
rcl ~/work ~/linux
rcl ~/git ~/linux
rcl ~/temp ~/linux
echo "Finished backing up"
