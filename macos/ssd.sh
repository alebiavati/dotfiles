#!/bin/bash

function setup_mac_ssd {
  # TODO: the following code dowsn't work
  # # Disable hibernation (speeds up entering sleep mode)
  # sudo_keep pmset -a hibernatemode 0

  # # Remove the sleep image file to save disk space
  # sudo_keep rm /private/var/vm/sleepimage
  # # Create a zero-byte file instead…
  # sudo_keep touch /private/var/vm/sleepimage
  # # …and make sure it can’t be rewritten
  # sudo_keep chflags uchg /private/var/vm/sleepimage
  print_success "Cannot remove sleepimage but that's a known issue, moving on"
}
