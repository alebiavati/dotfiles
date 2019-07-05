#!/bin/bash

setup_default_program () {
  local programId="$(osascript -e "id of app \"$1\"")"
  if ! (duti -x $2 | grep -q "$programId"); then
    duti -s "$programId" $2 all
  fi
}

setup_default_programs () {
  cat "${1:-duti}" | grep "^[^#;]" |
  while IFS=$':' read program extensions ; do
    IFS=$','
    for extension in $extensions; do
      setup_default_program $program $extension
      print_success "Set $program as default application for .$extension files"
    done
  done
}