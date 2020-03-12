#!/bin/bash

get_env_label() {
  case $1 in
    pyenv) echo "Python";;
    nodenv) echo "Node";;
    rbenv) echo "Ruby";;
    plenv) echo "Perl";;
    *) ;;
  esac
}

install_env() {
  local env_command=$1
  local title="$(get_env_label $1)"
  local version="$($env_command local)"

  $env_command install -s
  $env_command global $version

  print_success "Installed $title v$version via $env_command"
}
