#!/usr/bin/env bash
if [[ -f ~paranoidsp/git/xcape/xcape ]]; then
    echo "========================================" >> ~paranoidsp/.xcapelog ;
    xmodmap -display :0 -e 'remove Lock = Caps_Lock' 2>>~paranoidsp/.xcapelog
    xmodmap -display :0 -e 'keysym Caps_Lock = Control_L' 2>>~paranoidsp/.xcapelog
    xmodmap -display :0 -e 'add Control = Control_L' 2>>~paranoidsp/.xcapelog
    xmodmap -display :0 -e 'keysym Super_R = Caps_Lock' 2>>~paranoidsp/.xcapelog
    xmodmap -display :0 -e 'add Lock = Caps_Lock' 2>>~paranoidsp/.xcapelog
    echo "++++++++++++++++++++++++++++++++++++++++" >> ~paranoidsp/.xcapelog ;
    echo "Starting Xcape";
    if [[ `pgrep xcape` == "" ]] ; then
        xcape -e "Control_L=Escape" ;
        echo "Xcape started."
    else
        echo "Xcape already running.";
    fi
    echo "Success. ", `date ` >> ~paranoidsp/.xcapelog ;
    echo "========================================" >> ~paranoidsp/.xcapelog ;
else
    echo "----------------------------------------------------------------------------------------" >> ~paranoidsp/.xcapelog ;
fi

