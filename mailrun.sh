#!/usr/bin/env bash

# Check every ten seconds if the process identified as $1 is still 
# running. After 5 checks (~60 seconds), kill it. Return non-zero to 
# indicate something was killed.
monitor() {
  local pid=$1 i=0

  while ps $pid &>/dev/null; do
    if (( i++ > 8 )); then
      echo "Max checks reached. Sending SIGKILL to ${pid}..." >&2
      kill -9 $pid; return 1
    fi

    sleep 10
  done

  return 0
}

read -r pid < ~/.offlineimap/pid

if ps $pid &>/dev/null; then
  echo "Process $pid already running. Exiting..." >&2
  exit 1
fi

echo "==================================================================================================================" >>~/.offlineimap/stat
echo `date`, "     Running " >>~/.offlineimap/stat
echo "+++++++++++++++++++++++++++++++" >>~/.offlineimap/stat
for i in ~/.offlineimap/Account-viswanathkarthikeya/LocalStatus-sqlite/* ; do  echo $i, " ----" ; sqlite3 $i "pragma integrity_check;" >> ~/.offlineimap/stat ; done
echo "+++++++++++++++++++++++++++++++" >>~/.offlineimap/stat
offlineimap -o 2&>>~/.offlineimap/stat & monitor $!

echo "+++++++++++++++++++++++++++++++" >>~/.offlineimap/stat
echo `date`, "     Ran" >>~/.offlineimap/stat
echo "==================================================================================================================" >>~/.offlineimap/stat
notify-send "Synced Mail"
