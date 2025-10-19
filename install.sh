#!/bin/bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
CONFIG_DIR="$HOME/.config"

# XDG
ln -sf "$DOTFILES_DIR/.config/mimeapps.list" "$CONFIG_DIR/mimeapps.list"
ln -sf "$DOTFILES_DIR/.config/user-dirs.dirs" "$CONFIG_DIR/user-dirs.dirs"

# git
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.gitconfig-hsb" "$HOME/.gitconfig-hsb"

# ZSH
mkdir -p "$CONFIG_DIR/zsh"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.config/zsh/aliases.zsh" "$CONFIG_DIR/zsh/aliases.zsh"
ln -sf "$DOTFILES_DIR/.config/zsh/exports.zsh" "$CONFIG_DIR/zsh/exports.zsh"
ln -sf "$DOTFILES_DIR/.config/zsh/functions.zsh" "$CONFIG_DIR/zsh/functions.zsh"

# hypr
mkdir -p "$CONFIG_DIR/hypr"
ln -sf "$DOTFILES_DIR/.config/hypr/hypridle.conf" "$CONFIG_DIR/hypr/hypridle.conf"
ln -sf "$DOTFILES_DIR/.config/hypr/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf"
ln -sf "$DOTFILES_DIR/.config/hypr/hyprlock.conf" "$CONFIG_DIR/hypr/hyprlock.conf"
ln -sf "$DOTFILES_DIR/.config/hypr/hyprpaper.conf" "$CONFIG_DIR/hypr/hyprpaper.conf"

# waybar
mkdir -p "$CONFIG_DIR/waybar"
ln -sf "$DOTFILES_DIR/.config/waybar/config.jsonc" "$CONFIG_DIR/waybar/config.jsonc"
ln -sf "$DOTFILES_DIR/.config/waybar/style.css" "$CONFIG_DIR/waybar/style.css"
ln -sf "$DOTFILES_DIR/.config/waybar/wireguard-status.sh" "$CONFIG_DIR/waybar/wireguard-status.sh"
ln -sf "$DOTFILES_DIR/.config/waybar/wireguard-toggle.sh" "$CONFIG_DIR/waybar/wireguard-toggle.sh"
ln -sf "$DOTFILES_DIR/.config/waybar/gcal-agenda.sh" "$CONFIG_DIR/waybar/gcal-agenda.sh"

# kanshi
mkdir -p "$CONFIG_DIR/kanshi"
ln -sf "$DOTFILES_DIR/.config/kanshi/config" "$CONFIG_DIR/kanshi/config"

# rofi
mkdir -p "$CONFIG_DIR/rofi"
ln -sf "$DOTFILES_DIR/.config/rofi/config.rasi" "$CONFIG_DIR/rofi/config.rasi"

# kitty
mkdir -p "$CONFIG_DIR/kitty"
ln -sf "$DOTFILES_DIR/.config/kitty/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf"

# whipper
mkdir -p "$CONFIG_DIR/whipper"
ln -sf "$DOTFILES_DIR/.config/whipper/whipper.conf" "$CONFIG_DIR/whipper/whipper.conf"

# qutebrowser
mkdir -p "$CONFIG_DIR/qutebrowser"
ln -sf "$DOTFILES_DIR/.config/qutebrowser/config.py" "$CONFIG_DIR/qutebrowser/config.py"

# zathura
mkdir -p "$CONFIG_DIR/zathura"
ln -sf "$DOTFILES_DIR/.config/zathura/zathurarc" "$CONFIG_DIR/zathura/zathurarc"
