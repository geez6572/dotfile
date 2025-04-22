#!/bin/bash


# 获取当前连接的显示器信息
external_monitor=$(hyprctl monitors | grep -m 1 "DP" | awk '{print $1}')
laptop_monitor=$(hyprctl monitors | grep -m 1 "eDP" | awk '{print $1}')

if [ -n "$external_monitor" ]; then
    # 如果外接显示器存在，禁用笔记本屏幕
    hyprctl keyword monitor "$laptop_monitor,disable"
    hyprctl keyword monitor "$external_monitor,preferred,auto,1"
else
    # 如果没有外接显示器，启用笔记本屏幕
    hyprctl keyword monitor "$laptop_monitor,preferred,auto,1"
fi
