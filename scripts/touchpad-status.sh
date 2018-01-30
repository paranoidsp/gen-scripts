#!/usr/bin/env bash
xinput list-props 11 | awk '/141/ { print $NF;}'
