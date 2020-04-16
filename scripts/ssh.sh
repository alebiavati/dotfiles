#!/bin/bash

setup_ssh () {
  if [ ! -f $HOME/.ssh/id_rsa ]; then
    ssh-keygen
  fi

  eval "$(ssh-agent)"

  ssh-add || true 
}
