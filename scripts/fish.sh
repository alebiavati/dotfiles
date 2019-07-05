#!/usr/bin/env bash

setup_fish () {
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

install_fisher () {
  # install fisher
  if ! fish -c 'functions -q fisher'; then
    curl https://git.io/fisher --create-dirs -sLo $HOME/.config/fish/functions/fisher.fish
  fi
  print_success "Installed Fisher package manager"

  # install fisher plugins
  fish -c fisher
  print_success "Installed Fish plugins"
}
