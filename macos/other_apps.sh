#!/bin/bash

setup_other_apps () {

  # Enable the debug menu in Address Book
  defaults write com.apple.addressbook ABShowDebugMenu -bool true

  # Enable Dashboard dev mode (allows keeping widgets on the desktop)
  defaults write com.apple.dashboard devmode -bool true

  # Enable the debug menu in iCal (pre-10.8)
  defaults write com.apple.iCal IncludeDebugMenu -bool true

  # Use plain text mode for new TextEdit documents
  defaults write com.apple.TextEdit RichText -int 0
  # Open and save files as UTF-8 in TextEdit
  defaults write com.apple.TextEdit PlainTextEncoding -int 4
  defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

  # Enable the debug menu in Disk Utility
  defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
  defaults write com.apple.DiskUtility advanced-image-options -bool true

  # Auto-play videos when opened with QuickTime Player
  defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

  # Prevent Photos from opening automatically when devices are plugged in
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

  # Disable automatic emoji substitution (i.e. use plain text smileys)
  defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

  # Disable smart quotes as it’s annoying for messages that contain code
  defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

  # Disable continuous spell checking
  defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

  # Bypass the annoyingly slow t.co URL shortener
  defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true

}
