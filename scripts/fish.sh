#!/usr/bin/env bash

setup_fish () {
  if is_linux; then
    if [ -z "$(which fish)" ]; then
      apt-get update
      curl -sL https://deb.nodesource.com/setup_12.x | bash -
      apt-get install -y fish  thefuck python-pkg-resources grc upower python python-pip nodejs
      pip install awscli
      npm install -g yarn diff-so-fancy
    fi
  fi

  # add fish to accepted shells
  if ! grep -Fxq "$(which fish)" /etc/shells; then
    sudo_keep sh -c "echo '\n$(which fish)' >> /etc/shells"
  fi

  # switch to fish shell for current user
  case "${SHELL}" in
    (*fish) ;;
    (*) chsh -s $(which fish) ;;
  esac

  print_success "Set Fish as the default shell"
}

install_omf () {
  # install fisher
  if ! fish -c 'functions -q omf'; then
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
  fi
  print_success "Installed Oh My Fish package manager"
}
