#!/bin/bash

add_dock_app () {
  defaults write com.apple.dock persistent-apps -array-add "
<dict>
  <key>tile-data</key>
  <dict>
    <key>file-data</key>
    <dict>
      <key>_CFURLString</key>
      <string>/Applications/${1}.app</string>
      <key>_CFURLStringType</key>
      <integer>0</integer>
    </dict>
  </dict>
  <key>tile-type</key>
  <string>file-tile</string>
</dict>"
}

# Wipe dock icons
setup_dock_apps () {
  defaults write com.apple.dock persistent-apps -array

  OLDIFS=$IFS
  IFS=","
  for app in $1; do
    add_dock_app "$app"
  done
  IFS=$OLDIFS

  print_success "Added Dock applications"
}


# arrangement: 1 (sort by name), 2 (sort by date added)
# displayas: 0 (stack), 1 (folder)
# showas: 0 (grid), 1 (fan), 2 (list)
add_dock_folder () {
  folderParams=()

  OLDIFS=$IFS
  IFS="|"
  for folderParam in $1; do
    folderParams+=("$folderParam")
  done
  IFS=$OLDIFS

  local folderPath=${folderParams[0]}
  local arrangement=${folderParams[1]:-1}
  local displayas=${folderParams[2]:-1}
  local showas=${folderParams[3]:-0}

  defaults write com.apple.dock persistent-others -array-add "
<dict>
  <key>tile-data</key>
  <dict>
    <key>arrangement</key>
    <integer>$arrangement</integer>
    <key>displayas</key>
    <integer>$displayas</integer>
    <key>file-data</key>
    <dict>
      <key>_CFURLString</key>
      <string>$folderPath</string>
      <key>_CFURLStringType</key>
      <integer>0</integer>
    </dict>
    <key>showas</key>
    <integer>$showas</integer>
  </dict>
  <key>tile-type</key>
  <string>directory-tile</string>
</dict>"
}

setup_dock_folders () {
  defaults write com.apple.dock persistent-others -array

  OLDIFS=$IFS
  IFS=","
  for folder in $1; do
    add_dock_folder "$folder"
  done
  IFS=$OLDIFS

  print_success "Added Dock folders"
}

setup_mac_dock () {
  # Enable highlight hover effect for the grid view of a stack (Dock)
  defaults write com.apple.dock mouse-over-hilite-stack -bool true

  # Set the icon size of Dock items to 36 pixels
  defaults write com.apple.dock tilesize -int 36

  # Change minimize/maximize window effect
  defaults write com.apple.dock mineffect -string "scale"

  # Minimize windows into their application’s icon
  defaults write com.apple.dock minimize-to-application -bool true

  # Show indicator lights for open applications in the Dock
  defaults write com.apple.dock show-process-indicators -bool true

  # Don’t animate opening applications from the Dock
  defaults write com.apple.dock launchanim -bool false

  # Speed up Mission Control animations
  defaults write com.apple.dock expose-animation-duration -float 0.1

  # Disable Dashboard
  defaults write com.apple.dashboard mcx-disabled -bool true

  # Don’t show Dashboard as a Space
  defaults write com.apple.dock dashboard-in-overlay -bool true

  # Don’t automatically rearrange Spaces based on most recent use
  defaults write com.apple.dock mru-spaces -bool false

  # Remove the auto-hiding Dock delay
  defaults write com.apple.dock autohide-delay -float 0
  # Remove the animation when hiding/showing the Dock
  defaults write com.apple.dock autohide-time-modifier -float 0

  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  # Make Dock icons of hidden applications translucent
  defaults write com.apple.dock showhidden -bool true

  # Don’t show recent applications in Dock
  defaults write com.apple.dock show-recents -bool false

  # Hot corners
  # Possible values:
  #  0: no-op
  #  2: Mission Control
  #  3: Show application windows
  #  4: Desktop
  #  5: Start screen saver
  #  6: Disable screen saver
  #  7: Dashboard
  # 10: Put display to sleep
  # 11: Launchpad
  # 12: Notification Center
  # Top left screen corner
  defaults write com.apple.dock wvous-tl-corner -int 0
  defaults write com.apple.dock wvous-tl-modifier -int 0
  # Top right screen corner
  defaults write com.apple.dock wvous-tr-corner -int 0
  defaults write com.apple.dock wvous-tr-modifier -int 0
  # Bottom left screen corner
  defaults write com.apple.dock wvous-bl-corner -int 0
  defaults write com.apple.dock wvous-bl-modifier -int 0
  # Bottom right screen corner
  defaults write com.apple.dock wvous-br-corner -int 0
  defaults write com.apple.dock wvous-br-modifier -int 0
}

clear_icon_cache () {
  sudo rm -rf /Library/Caches/com.apple.iconservices.store
}
