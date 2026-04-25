#!/bin/bash

# --- 配置 ---
WALL_DIR="$HOME/.config/hypr/wallpaper/"
CACHE_DIR="$HOME/.cache/rofi-wallpaper-thumbs"
ROFI_THEME="$HOME/.config/rofi/wallpaper/config.rasi"

# --- 修改这里：新的比例 4:5 ---
# 宽度增加，高度减少
# 320x400 是一个非常适合 1080p/2k 屏幕展示 5 列的大小
THUMB_W=320
THUMB_H=400

# 创建缓存目录
mkdir -p "$CACHE_DIR"

# --- 核心逻辑 (保持不变) ---
generate_thumbnail() {
  local img="$1"
  local filename=$(basename "$img")
  local thumb="$CACHE_DIR/$filename"

  if [ ! -f "$thumb" ]; then
    # 这里的 magick 命令会自动裁剪中间部分填满 320x400
    magick "$img" -resize "${THUMB_W}x${THUMB_H}^" -gravity center -extent "${THUMB_W}x${THUMB_H}" "$thumb"
  fi
  echo "$thumb"
}

# 生成 Rofi 列表 (保持不变)
selected=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort | while read -r img; do
  filename=$(basename "$img")
  thumb_path=$(generate_thumbnail "$img")
  echo -en "$filename\0icon\x1f$thumb_path\n"
done | rofi -dmenu -theme "$ROFI_THEME" -show-icons -p "🖼️ Wallpapers")

# 应用壁纸 (保持不变)
if [ ! -z "$selected" ]; then
  FULL_PATH="$WALL_DIR/$selected"
  echo "$FULL_PATH" >"$HOME/.cache/current_wallpaper"
  awww img "$FULL_PATH" --transition-type grow --transition-pos 0.854,0.977 --transition-step 90 --transition-fps 60
  notify-send "Wallpaper Changed" "$selected" -i "$FULL_PATH"
fi
