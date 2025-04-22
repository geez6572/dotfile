#!/bin/bash

file_prefix="/home/ce/tmp/hyprland_hide/workspace"

function hide_window() {
  pid=$(hyprctl activewindow -j | jq '.pid')
  current_workspace=$(hyprctl -j activeworkspace | jq -r '.id')
  cur_file="${file_prefix}${current_workspace}"
  [ $pid = 'null' ] && exit
  hyprctl dispatch movetoworkspacesilent special:hidden,pid:$pid
  echo $pid >>$cur_file
}

function show_window() {
  current_workspace=$(hyprctl activeworkspace -j | jq '.id')
  cur_file="${file_prefix}${current_workspace}"
  pid=$(tail -1 $cur_file && sed -i '$d' $cur_file)
  [ -z $pid ] && exit
  hyprctl dispatch movetoworkspacesilent $current_workspace,pid:$pid
}

if [ ! -z $1 ]; then
  if [ "$1" == "h" ]; then
    hide_window >>/dev/null
  else
    show_window >>/dev/null
  fi
fi
