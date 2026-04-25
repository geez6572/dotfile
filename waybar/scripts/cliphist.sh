#!/usr/bin/env bash
#   ____ _ _       _     _     _
#  / ___| (_)_ __ | |__ (_)___| |_
# | |   | | | '_ \| '_ \| / __| __|
# | |___| | | |_) | | | | \__ \ |_
#  \____|_|_| .__/|_| |_|_|___/\__|
#           |_|
#

# -----------------------------------------------------
# Load Launcher
# -----------------------------------------------------
case $1 in
d)
  cliphist list | rofi -dmenu -replace -config ~/.config/rofi/clipboard/config.rasi | cliphist delete
  ;;
w)
  cliphist wipe
  ;;
*)
  cliphist list | rofi -dmenu -replace -config ~/.config/rofi/clipboard/config.rasi | cliphist decode | wl-copy
  ;;
esac
