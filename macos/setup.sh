#!/bin/bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
close_system_prefs () {
  osascript -e 'tell application "System Preferences" to quit'
}

# Define Function =init_paths=
setup_paths () {
  test -x "/usr/libexec/path_helper" && eval $(/usr/libexec/path_helper -s)
}

# Set Hostname from DNS
setup_hostname () {
  local defaultHostname="$(hostname -s)"
  ask "Set Computer Name and Hostname" "$defaultHostname"
  local desiredHostname=$(get_answer)

  if [ "$desiredHostname" != "$defaultHostname" ]; then
    sudo scutil --set ComputerName "$desiredHostname"
    sudo scutil --set HostName "$desiredHostname"
    sudo scutil --set LocalHostName "$desiredHostname"
    dscacheutil -flushcache
  fi

  print_success "Set Computer Name and Hostname to $defaultHostname"
}

# Improve performance when using NPM and Git
setup_filesys () {
  # default is (257*1024)
  sudo sysctl kern.maxvnodes=$((512*1024))
  echo kern.maxvnodes=$((512*1024)) | sudo tee -a /etc/sysctl.conf

  # https://facebook.github.io/watchman/docs/install.html#mac-os-file-descriptor-limits
  sudo sysctl -w kern.maxfiles=$((10*1024*1024))
  sudo sysctl -w kern.maxfilesperproc=$((1024*1024))
  echo kern.maxfiles=$((10*1024*1024)) | sudo tee -a /etc/sysctl.conf
  echo kern.maxfilesperproc=$((1024*1024)) | sudo tee -a /etc/sysctl.conf
}
