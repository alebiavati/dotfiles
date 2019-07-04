#!/bin/bash

# Install Homebrew Package Manager

install_brew () {
  if ! which brew > /dev/null; then
    URL_BREW='https://raw.githubusercontent.com/Homebrew/install/master/install'
    echo -n '- Installing brew ... '
    echo | /usr/bin/ruby -e "$(curl -fsSL $URL_BREW)" > /dev/null
    if [ $? -eq 0 ]; then echo 'OK'; else echo 'NG'; fi
    brew analytics off
    brew update
    brew doctor
  fi
  print_success "Installed Homebrew"
}

brew_bundle () {
  brew bundle
  print_success "Installed packages"
}
