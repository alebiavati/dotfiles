#!/bin/bash

symlink_dotfiles() {
  for i in $1; do
    sourceFile="$(pwd)/$i"
    targetFile="$HOME/$i"

    # Make sure the target dir exists
    targetDir="$(dirname $targetFile)"
    mkdir -p $targetDir

    if [ -e "$targetFile" ]; then
      if [ "$(readlink "$targetFile")" != "$sourceFile" ]; then

        ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
        if answer_is_yes; then
          rm -rf "$targetFile"
          execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        else
          print_error "$targetFile → $sourceFile"
        fi

      else
        print_success "$targetFile → $sourceFile"
      fi
    else
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    fi
  done
}

