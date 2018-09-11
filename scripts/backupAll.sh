#!/bin/bash

# This script rsync's most of home into corresponding folders in svalbard

rcl() {
  rclone -L --stats 5s --stats-log-level NOTICE $@
}

rcl copy ~/Music ~/svalbard/Music
rcl copy ~/Videos ~/svalbard/Videos
rcl copy ~/Downloads ~/svalbard/Downloads
rcl copy ~/Pictures ~/svalbard/Pictures
rcl copy ~/Documents ~/svalbard/Documents
rcl copy ~/work ~/linux/work
rcl copy ~/git ~/linux/git
rcl copy ~/temp ~/linux/temp
echo "Finished backing up"
