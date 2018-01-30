#!/usr/bin/env bash
xinput list-props 11 | awk '/141/ { print $NF;}'
if [[ `xinput list-props 11 | awk '/141/ { print $NF;}'` -eq 0 ]] ; then
    if `synclient TouchpadOff=1 &>/dev/null`; then
        echo "Successfully turned off touchpad."
    else 
        if [[ `xinput set-prop 11 141 1` ]]; then
            echo "Successfully turned off touchpad."
        fi
    fi
else
    if `synclient TouchpadOff=0 &>/dev/null`; then
        echo "Successfully turned on touchpad."
    else 
        if [[ `xinput set-prop 11 141 0` ]]; then
            echo "Successfully turned on touchpad."
        fi
    fi
fi
