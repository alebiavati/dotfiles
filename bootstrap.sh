#!/usr/bin/env bash

# stop script if anything goes wrong
set -e
set -u
set -o pipefail

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


#######################################################
# CONSTANTS - change to your needs
#######################################################

CODE_DIR="$HOME/code"
REPO_DIR=$CODE_DIR/.dotfiles
SCREENSHOTS_DIR="$HOME/Screenshots"
GH_USER="alebiavati"
GH_REPO="dotfiles"


#######################################################
# DOWNLOAD REPO
#######################################################

printf "\n\033[1m\033[34m%s\033[0m\n\n" "Download"

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

# Import dotfiles scripts now that they have been downloaded
source ./scripts/utils.sh

print_success "Cloned $GH_USER/$GH_REPO repository into $REPO_DIR"


#######################################################
# DOTFILES
#######################################################

p "Dotfiles"

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
)

symlink_dotfiles "${FILES_TO_SYMLINK[*]}"

# Adding .hushlogin to silence terminal login
touch $HOME/.hushlogin


#######################################################
# GIT
#######################################################

p "Git"

# get utility scripts
source ./scripts/git.sh

# create .gitconfig.local
setup_gitconfig_local


#######################################################
# SETUP
#######################################################

p "Setup"

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


#######################################################
# HOMEBREW
#######################################################

p "Homebrew"

# get utility scripts
source ./macos/brew.sh

# Install Homebrew Package Manager
install_brew

# Install Homebrew Packages
brew_bundle


#######################################################
# Terminal
#######################################################

p "Terminal"

# get utility scripts
source ./scripts/fish.sh
source ./scripts/tpm.sh
source ./macos/terminal.sh

# Setup Fish shell as default shell
setup_fish

# Install Fisher
install_fisher

# install Tmux package manager
install_tpm

# setup Mac Terminal
setup_mac_terminal

# setup iTerm2
setup_iterm2


#######################################################
# XCODE
#######################################################

p "XCode"

# get utility scripts
source ./macos/xcode.sh

# Setup xcode
setup_xcode


#######################################################
# General UI/UX
#######################################################

p "General UI/UX"

# get utility scripts
source ./macos/ux.sh

setup_mac_ux


#######################################################
# SSD-specific tweaks
#######################################################

p "SSD"

# get utility scripts
source ./macos/ssd.sh

setup_mac_ssd


#######################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
#######################################################

p "Inputs & Bluetooth"

# get utility scripts
source ./macos/inputs.sh

setup_mac_inputs


#######################################################
# Screen
#######################################################

p "Screen"

# get utility scripts
source ./macos/screen.sh

setup_mac_screen


#######################################################
# Finder
#######################################################

p "Finder"

# get utility scripts
source ./macos/finder.sh

setup_mac_finder


#######################################################
# Safari
#######################################################

p "Safari"

# get utility scripts
source ./macos/safari.sh

setup_safari


#######################################################
# Mail
#######################################################

p "Mail"

# get utility scripts
source ./macos/mail.sh

setup_mail


#######################################################
# Spotlight
#######################################################

p "Spotlight"

# get utility scripts
source ./macos/spotlight.sh

setup_spotlight


#######################################################
# Spotlight
#######################################################

p "Spotlight"

# get utility scripts
source ./macos/spotlight.sh

setup_spotlight


#######################################################
# Time Machine
#######################################################

p "Time Machine"

# get utility scripts
source ./macos/time_machine.sh

setup_time_machine


#######################################################
# Activity Monitor
#######################################################

p "Activity Monitor"

# get utility scripts
source ./macos/activity_monitor.sh

setup_activity_monitor


#######################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility
#######################################################

p "Address Book, Dashboard, iCal, TextEdit, and Disk Utility"

# get utility scripts
source ./macos/other_apps.sh

setup_other_apps


#######################################################
# App Store
#######################################################

p "App Store"

# get utility scripts
source ./macos/app_store.sh

setup_app_store


#######################################################
# Google Chrome
#######################################################

p "Google Chrome"

# get utility scripts
source ./macos/google_chrome.sh

setup_google_chrome


#######################################################
# Transmission
#######################################################

p "Transmission"

# get utility scripts
source ./macos/transmission.sh

setup_transmission


#######################################################
# Dock
#######################################################

p "Dock"

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

#######################################################
# RESTART APPS
#######################################################

p "Cleanup"

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

#######################################################
# DONE
#######################################################

p "OK: Completed. Note that some of these changes require a logout/restart to take effect."
