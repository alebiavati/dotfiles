#!/usr/bin/env bash

# stop script if anything goes wrong
set -e
set -u
set -o pipefail


#######################################################
# UTILS
#######################################################

print_title () { printf "\n\033[1m\033[34m%s\033[0m\n\n" "${1}"; }
print_success () { printf "\e[0;32m  [✔] $1\e[0m\n"; }
print_info() { printf "\n\e[0;35m $1\e[0m\n\n"; }
print_question() { printf "\e[0;33m  [?] $1\e[0m"; }
print_error() { printf "\e[0;31m  [✖] $1 ${2:-}\e[0m\n"; }
ask_for_confirmation() {
  print_question "$1 (Y/n) ";
  read -n 1
  test "${REPLY:-}" != "" && printf "\n"
  REPLY="${REPLY:-Y}"
}
answer_is_yes() { [[ "$REPLY" =~ ^[Yy]$ ]] && return 0 || return 1; }

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

is_linux() { [[ "$machine" = "Linux" ]] && return 0 || return 1; }
is_mac() { [[ "$machine" = "Mac" ]] && return 0 || return 1; }


#######################################################
# CONSTANTS - change to your needs
#######################################################

CODE_DIR="$HOME/code"
REPO_DIR=$CODE_DIR/.dotfiles
SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"
GH_USER="alebiavati"
GH_REPO="dotfiles"

print_title "Constants"

echo "  CODE_DIR=$CODE_DIR"
echo "  REPO_DIR=$REPO_DIR"
echo "  SCREENSHOTS_DIR=$SCREENSHOTS_DIR"
echo "  GH_USER=$GH_USER"
echo "  GH_REPO=$GH_REPO"
echo ""

ask_for_confirmation "Are the constants above correct?"
if answer_is_yes; then
  print_success "Correct constants"
else
  print_error "Wrong constants, clone repository and modify them."
  exit 1
fi


#######################################################
# SETUP XCODE SELECT TO USE GIT
#######################################################

if is_mac; then
print_title "XCode Select"

if ! xcode-select --print-path &> /dev/null; then
  # Prompt user to install the XCode Command Line Tools
  xcode-select --install &> /dev/null

  # Wait until the XCode Command Line Tools are installed
  until xcode-select --print-path &> /dev/null; do
    sleep 5
  done
fi

print_success 'Install XCode Command Line Tools'
fi


#######################################################
# DOWNLOAD REPO
#######################################################

print_title "Download Dotfiles Repo"

# Make sure that the code folder exists
if [ ! -d $CODE_DIR ]; then
  mkdir -p $CODE_DIR
fi

# check if we need to download the dotfiles repo
if [ ! -d $REPO_DIR ]; then
  cd $CODE_DIR
  git clone https://github.com/$GH_USER/$GH_REPO.git $REPO_DIR
  cd $REPO_DIR
  # Once cloned we can set the remote URL to use SSH for future updates (will require ssh-keygen)
  git remote set-url origin git@github.com:$GH_USER/$GH_REPO.git
else
  cd $REPO_DIR
  # TODO: update repo
fi

print_success "Cloned $GH_USER/$GH_REPO repository into $REPO_DIR"

# source remaining utilities
source ./scripts/utils.sh

#######################################################
# DOTFILES
#######################################################

print_title "Dotfiles"

# get utility scripts
source ./scripts/symlink.sh

# Symlink all necessary files
FILES_TO_SYMLINK=(
  .gitattributes
  .gitconfig
  .gitignore
  .tmux
  .tmux.conf
  .vim
  .vimrc
  bin
  .config/fish
  .config/starship.toml
)

symlink_dotfiles "${FILES_TO_SYMLINK[*]}"

# Adding .hushlogin to silence terminal login
touch $HOME/.hushlogin


#######################################################
# GIT
#######################################################

print_title "Git"

# get utility scripts
source ./scripts/git.sh

# create .gitconfig.local
setup_gitconfig_local


#######################################################
# SSH
#######################################################

print_title "SSH"

# get utility scripts
source ./scripts/ssh.sh

# Setup SSH key
setup_ssh


#######################################################
# SETUP
#######################################################

if is_mac; then
print_title "Setup"

# get utility scripts
source ./macos/setup.sh

# Close system preferences to avoid overrides
close_system_prefs

# setup initial paths
setup_paths

# Set computer hostname
setup_hostname

# Improve performance when using NPM and Git
setup_filesys
fi


#######################################################
# HOMEBREW
#######################################################

if is_mac; then
print_title "Homebrew"

# get utility scripts
source ./macos/brew.sh

# Install Homebrew Package Manager
install_brew

# Install Homebrew Packages
brew_bundle
fi

#######################################################
# XCODE
#######################################################

if is_mac; then
print_title "XCode"

# get utility scripts
source ./macos/xcode.sh

# Setup xcode
setup_xcode
fi

#######################################################
# Extensions
#######################################################

if is_mac; then
print_title "Extensions"

# get utility scripts
source ./macos/extensions.sh

setup_default_programs
fi


#######################################################
# Terminal
#######################################################

print_title "Terminal"

# get utility scripts
source ./scripts/fish.sh
source ./scripts/tpm.sh

if is_mac; then
source ./macos/terminal.sh
fi

# Setup Fish shell as default shell
setup_fish

# Install Fisher
install_omf

# install Tmux package manager
install_tpm

if is_mac; then
# setup Mac Terminal
setup_mac_terminal

# setup iTerm2
setup_iterm2
fi

#######################################################
# Node, Ruby, Python, Perl
#######################################################

if is_mac; then
print_title "Node, Ruby, Python, Perl"

# get utility scripts
source ./scripts/env-utils.sh

install_env pyenv
install_env nodenv
install_env rbenv
# install_env plenv # currently broken https://github.com/tokuhirom/plenv/issues/147
fi

#######################################################
# General UI/UX
#######################################################

if is_mac; then
print_title "General UI/UX"

# get utility scripts
source ./macos/ux.sh

setup_mac_ux
fi


#######################################################
# SSD-specific tweaks
#######################################################

if is_mac; then
print_title "SSD"

# get utility scripts
source ./macos/ssd.sh

setup_mac_ssd
fi

#######################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
#######################################################

if is_mac; then
print_title "Inputs & Bluetooth"

# get utility scripts
source ./macos/inputs.sh

setup_mac_inputs
fi

#######################################################
# Screen
#######################################################

if is_mac; then
print_title "Screen"

# get utility scripts
source ./macos/screen.sh

setup_mac_screen
fi


#######################################################
# Finder
#######################################################

if is_mac; then
print_title "Finder"

# get utility scripts
source ./macos/finder.sh

setup_mac_finder
fi


#######################################################
# Safari
#######################################################

if is_mac; then
print_title "Safari"

# get utility scripts
source ./macos/safari.sh

setup_safari
fi


#######################################################
# Mail
#######################################################

if is_mac; then
print_title "Mail"

# get utility scripts
source ./macos/mail.sh

setup_mail
fi


#######################################################
# Spotlight
#######################################################

if is_mac; then
print_title "Spotlight"

# get utility scripts
source ./macos/spotlight.sh

setup_spotlight
fi


#######################################################
# Spotlight
#######################################################

if is_mac; then
print_title "Spotlight"

# get utility scripts
source ./macos/spotlight.sh

setup_spotlight
fi

#######################################################
# Time Machine
#######################################################

if is_mac; then
print_title "Time Machine"

# get utility scripts
source ./macos/time_machine.sh

setup_time_machine
fi

#######################################################
# Activity Monitor
#######################################################

if is_mac; then
print_title "Activity Monitor"

# get utility scripts
source ./macos/activity_monitor.sh

setup_activity_monitor
fi


#######################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility
#######################################################

if is_mac; then
print_title "Address Book, Dashboard, iCal, TextEdit, and Disk Utility"

# get utility scripts
source ./macos/other_apps.sh

setup_other_apps
fi


#######################################################
# App Store
#######################################################

if is_mac; then
print_title "App Store"

# get utility scripts
source ./macos/app_store.sh

setup_app_store
fi


#######################################################
# Google Chrome
#######################################################

if is_mac; then
print_title "Google Chrome"

# get utility scripts
source ./macos/google_chrome.sh

setup_google_chrome
fi


#######################################################
# Transmission
#######################################################

if is_mac; then
print_title "Transmission"

# get utility scripts
source ./macos/transmission.sh

setup_transmission
fi


#######################################################
# Slack
#######################################################

if is_mac; then
print_title "Slack"

# get utility scripts
source ./macos/slack.command
print_success "Set dark theme for slack"
fi


#######################################################
# Dock
#######################################################

if is_mac; then
print_title "Dock"

# get utility scripts
source ./macos/dock.sh

setup_mac_dock

# Setup Dock apps and other folders
DOCK_APPS=(
  "Google Chrome"
  "Mailplane"
  "Trello"
  "TogglDesktop"
  "Quip"
  "Tweetbot"
  "Messenger"
  "WhatsApp"
  "Messages"
  "Skype"
  "Slack"
  "Sketch"
  "Visual Studio Code"
  "iTerm"
  "Sourcetree"
  "Dashlane"
  "Authy Desktop"
  "Spotify"
)

# Folder view options: "path|arrangement|displayas|showas"
#  - arrangement: 1 (sort by name), 2 (sort by date added)
#  - displayas: 0 (stack), 1 (folder)
#  - showas: 0 (grid), 1 (fan), 2 (list)
DOCK_FOLDERS=(
  "/Applications"
  "$SCREENSHOTS_DIR|2|0|1"
  "$HOME/Downloads|2|0|1"
)

OLDIFS=$IFS
IFS=","
DOCK_APPS_CSV="${DOCK_APPS[*]}"
DOCK_FOLDERS_CSV="${DOCK_FOLDERS[*]}"
IFS=$OLDIFS

setup_dock_apps "$DOCK_APPS_CSV"
setup_dock_folders "$DOCK_FOLDERS_CSV"

# Clear icon cache
clear_icon_cache
fi

#######################################################
# RESTART APPS
#######################################################

if is_mac; then
print_title "Cleanup"

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome Canary" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Photos" \
	"Safari" \
	"SizeUp" \
	"Spectacle" \
	"SystemUIServer" \
	"Transmission" \
	"Tweetbot" \
	"Twitter" \
	"iCal"; do
	killall -KILL "$app" &> /dev/null || true
done

print_success "Killed affected apps"
fi

#######################################################
# DONE
#######################################################

print_title "OK: Completed. Note that some of these changes require a logout/restart to take effect."
