#!/usr/bin/env bash

set -e

# Required packages
packages=(
  i3
  picom
  dunst
  rofi
  polybar
)

echo "🟢 Installing packages..."
sudo apt update
sudo apt install -y "${packages[@]}"

# Backup and deploy configs
config_dirs=(i3 picom dunst rofi polybar scripts)
for dir in "${config_dirs[@]}"; do
  src="./$dir"
  dest="$HOME/.config/$dir"

  if [ -d "$dest" ]; then
    echo "🟡 Backing up existing $dir config to $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  echo "📁 Deploying $dir config to $dest"
  cp -r "$src" "$dest"
done

# Make scripts executable
if [ -d "$HOME/.config/scripts" ]; then
  echo "⚙️  Making scripts in ~/.config/scripts executable"
  chmod +x "$HOME/.config/scripts"/*
fi

echo "✅ Done. Log out and back in or restart i3 to apply changes."
