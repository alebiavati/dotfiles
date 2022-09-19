# Garmin SDK path
set -x GARMIN_SDK_PATH (cat $HOME/Library/Application\ Support/Garmin/ConnectIQ/current-sdk.cfg)
if test -e $GARMIN_SDK_PATH/bin
  set -g fish_user_paths "$GARMIN_SDK_PATH/bin" $fish_user_paths
end
