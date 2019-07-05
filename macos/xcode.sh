#!/bin/bash

setup_xcode () {
  # Add iOS & Watch Simulator to Launchpad
  sudo_keep ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
  print_success "Add iOS Simulator to Applications"

  # Point the `xcode-select` developer directory to
  # the appropriate directory from within `Xcode.app`
  # https://github.com/alrra/dotfiles/issues/13
  local xcodepath=/Applications/Xcode.app/Contents/Developer
  if [ "$(xcode-select --print-path)" != "$xcodepath" ]; then
    sudo_keep xcode-select -switch $xcodepath
  fi
  print_result $? 'Make "xcode-select" developer directory point to Xcode'

  if ! sudo_keep xcodebuild -checkFirstLaunchStatus &> /dev/null; then
    # Accept XCode terms after installation
    sudo_keep xcodebuild -license accept

    # Prompt user to install the XCode Command Line Tools
    sudo_keep xcodebuild -runFirstLaunch

    # Wait until the XCode Command Line Tools are installed
    until sudo_keep xcodebuild -checkFirstLaunchStatus &> /dev/null; do
      sleep 5
    done
  fi

  print_success "Install XCode packages and agree to the license"
}
