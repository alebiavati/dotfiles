#!/bin/bash

setup_mac_screen() {

  # # Require password immediately after sleep or screen saver begins
  # profiles -I -F ./assets/askforpassworddelay.mobileconfig

  # Make sure that the code folder exists
  if [ ! -d $SCREENSHOTS_DIR ]; then
    mkdir -p $SCREENSHOTS_DIR
  fi
  defaults write com.apple.screencapture location -string "$SCREENSHOTS_DIR"

  # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
  defaults write com.apple.screencapture type -string "png"

  # Enable subpixel font rendering on non-Apple LCDs
  # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
  defaults write NSGlobalDomain AppleFontSmoothing -int 1

  # Enable HiDPI display modes (requires restart)
  sudo_keep defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

}
