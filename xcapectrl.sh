#!/usr/bin/env bash
if [[ -f "~paranoidsp/git/xcape/xcape" ]]; then
    pkill xcape
    ~paranoidsp/git/xcape/xcape -e "Control_L=Escape" ;
fi

