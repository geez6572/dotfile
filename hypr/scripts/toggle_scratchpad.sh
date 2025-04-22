#!/bin/bash

# 定义终端窗口的类名（根据实际终端修改，如 Alacritty、kitty 等）
TERMINAL_CLASS="scratchpad"
TERM="kitty"
SCRATCHPAD_WORKSPACE="special:scratchpad" # Hyprland 特殊工作区

# 检查 Scratchpad 中是否存在终端窗口
SCRATCHPAD_TERM=$(hyprctl -j clients | jq -r ".[] | select(.class == \"$TERMINAL_CLASS\" and .workspace.name == \"$SCRATCHPAD_WORKSPACE\") | .address")

$TERM &
sleep 0.5 # 等待终端启动
NEW_TERM_ADDRESS=$(hyprctl -j clients | jq -r ".[] | select(.class == \"$TERMINAL_CLASS\") | .address" | tail -n 1)
echo $NEW_TERM_ADDRESS
hyprctl dispatch movetoworkspacesilent "$SCRATCHPAD_WORKSPACE,address:$NEW_TERM_ADDRESS"
hyprctl dispatch togglefloating "address:$NEW_TERM_ADDRESS"
#if [ -n "$SCRATCHPAD_TERM" ]; then
#  # 如果存在，检查是否可见（当前是否在活动工作区）
#  IS_VISIBLE=$(hyprctl -j activewindow | jq -r ".address == \"$SCRATCHPAD_TERM\"")
#
#  if [ "$IS_VISIBLE" = "true" ]; then
#    # 如果可见，则隐藏到 Scratchpad
#    hyprctl dispatch movetoworkspacesilent "$SCRATCHPAD_WORKSPACE,address:$SCRATCHPAD_TERM"
#  else
#    # 如果不可见，则显示到当前工作区
#    hyprctl dispatch focuswindow "address:$SCRATCHPAD_TERM"
#    hyprctl dispatch togglefloating "address:$SCRATCHPAD_TERM"
#  fi
#else
#  # 不存在则新建终端，并移动到 Scratchpad
#  $TERM &
#  sleep 0.5 # 等待终端启动
#  NEW_TERM_ADDRESS=$(hyprctl -j clients | jq -r ".[] | select(.class == \"$TERMINAL_CLASS\") | .address" | tail -n 1)
#  echo $NEW_TERM_ADDRESS
#  hyprctl dispatch movetoworkspacesilent "$SCRATCHPAD_WORKSPACE,address:$NEW_TERM_ADDRESS"
#  hyprctl dispatch togglefloating "address:$NEW_TERM_ADDRESS"
#fi
