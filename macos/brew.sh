#!/bin/bash

# Install Homebrew Package Manager

install_brew () {
  if ! which brew > /dev/null; then
    ruby -e \
      "$(curl -Ls 'https://github.com/Homebrew/install/raw/master/install')" \
      < /dev/null > /dev/null 2>&1
  fi
  brew analytics off
  brew update
  brew doctor
  print_success "Installed Homebrew"
}

brew_bundle () {
  brew bundle
  print_success "Installed packages"
}
