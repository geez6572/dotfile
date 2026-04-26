#!/bin/bash

# 获取所有已连接输出接口的名称 (去除 eDP-1)
# wlr-randr 的输出第一行通常是接口名，我们过滤掉 eDP-1
EXTERNAL_MONITORS=$(wlr-randr | grep "^[^ ]" | awk '{print $1}' | grep -v "eDP-1")

if [ -n "$EXTERNAL_MONITORS" ]; then
  # 如果变量不为空，说明检测到了 eDP-1 以外的显示器
  echo "检测到外部显示器: $EXTERNAL_MONITORS，正在关闭内屏..."
  wlr-randr --output eDP-1 --off
else
  # 变量为空，说明只有内屏
  echo "未检测到外部显示器，正在开启内屏..."
  wlr-randr --output eDP-1 --on --pos 0,0
fi
