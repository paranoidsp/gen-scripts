#!/bin/bash

# This script rsync's most of home into corresponding folders in svalbard

rsync --partial --progress --append --rsh=ssh -r -h ~/Music ~/babel
rsync --partial --progress --append --rsh=ssh -r -h ~/Videos ~/babel
rsync --partial --progress --append --rsh=ssh -r -h ~/Downloads ~/babel
rsync --partial --progress --append --rsh=ssh -r -h ~/Pictures ~/babel

rsync --partial --progress --append --rsh=ssh -r -h ~/git ~/arch
rsync --partial --progress --append --rsh=ssh -r -h ~/work ~/arch
echo "Finished backing up"
