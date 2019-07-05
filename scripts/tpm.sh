#!/bin/bash

install_tpm () {
  if ! is_app_installed tmux; then
    printf "WARNING: \"tmux\" command is not found. Install it first\n"
    exit 1
  fi

  if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  print_success "Installed Tmux package manager"

  # Install TPM plugins.
  # TPM requires running tmux server, as soon as `tmux start-server` does not work
  # create dump __noop session in detached mode, and kill it when plugins are installed
  tmux new -d -s __noop >/dev/null 2>&1 || true
  tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
  "$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
  tmux kill-session -t __noop >/dev/null 2>&1 || true

  print_success "Installed Tmux plugins"
}
