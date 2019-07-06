#!/bin/bash

setup_mac_terminal () {
  # Only use UTF-8 in Terminal.app
  defaults write com.apple.terminal StringEncodings -array 4

  # Enable “focus follows mouse” for Terminal.app and all X11 apps
  # i.e. hover over a window and start typing in it without clicking first
  #defaults write com.apple.terminal FocusFollowsMouse -bool true
  #defaults write org.x.X11 wm_ffm -bool true

  # Enable Secure Keyboard Entry in Terminal.app
  # See: https://security.stackexchange.com/a/47786/8918
  defaults write com.apple.terminal SecureKeyboardEntry -bool true

  # Disable the annoying line marks
  defaults write com.apple.Terminal ShowLineMarks -int 0

  # Set terminal font
  osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"FiraCode-Regular\""
  osascript -e "tell application \"Terminal\" to set the font size of window 1 to 14"
}

setup_iterm2 () {
  # Load/save configuration in dotfiles folder
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$REPO_DIR/prefs"

  print_success "Set iTerm2 preferences custom folder location to point to dotfiles repo"

  # install iTerm2 shell integration
  local iterm2_shell_integration_file=$HOME/.iterm2_shell_integration.fish
  if [ ! -f "$iterm2_shell_integration_file" ]; then
    curl -L https://iterm2.com/shell_integration/fish -o $iterm2_shell_integration_file
  fi

  print_success "Installed iTerm Shell Integration"
}
