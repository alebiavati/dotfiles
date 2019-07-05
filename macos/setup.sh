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
  local oldHostname="$(hostname -s)"
  local newHostname="$USER-macbookpro"

  if [ "$oldHostname" != "$newHostname" ]; then
    sudo_keep scutil --set ComputerName "$newHostname"
    sudo_keep scutil --set HostName "$newHostname"
    sudo_keep scutil --set LocalHostName "$newHostname"
    dscacheutil -flushcache
  fi

  print_success "Set Computer Name and Hostname to $newHostname"
}

# unused utility that will prompt for the hostname
setup_hostname_prompt () {
  local defaultHostname="$(hostname -s)"
  ask "Set Computer Name and Hostname" "$defaultHostname"
  local desiredHostname=$(get_answer)

  if [ "$desiredHostname" != "$defaultHostname" ]; then
    sudo_keep scutil --set ComputerName "$desiredHostname"
    sudo_keep scutil --set HostName "$desiredHostname"
    sudo_keep scutil --set LocalHostName "$desiredHostname"
    dscacheutil -flushcache
  fi

  print_success "Set Computer Name and Hostname to $defaultHostname"
}

# Improve performance when using NPM and Git
setup_filesys () {
  local SYSCTL_FILE="/etc/sysctl.conf"

  local maxvnodes=$((1024*1024))
  if ! grep -q "kern.maxvnodes=$maxvnodes" "$SYSCTL_FILE"; then
    sudo_keep sysctl kern.maxvnodes=$maxvnodes
    echo kern.maxvnodes=$maxvnodes | sudo_keep tee -a /etc/sysctl.conf
  fi

  local maxfiles=$((1024*1024))
  if ! grep -q "kern.maxfiles=$maxfiles" "$SYSCTL_FILE"; then
    sudo_keep sysctl -w kern.maxfiles=$maxfiles
    echo kern.maxfiles=$maxfiles | sudo_keep tee -a /etc/sysctl.conf
  fi

  local maxfilesperproc=$((1024*1024))
  if ! grep -q "kern.maxfilesperproc=$maxfilesperproc" "$SYSCTL_FILE"; then
    sudo_keep sysctl -w kern.maxfilesperproc=$maxfilesperproc
    echo kern.maxfilesperproc=$maxfilesperproc | sudo_keep tee -a /etc/sysctl.conf
  fi

  print_success "Set SysCtl values"
}
