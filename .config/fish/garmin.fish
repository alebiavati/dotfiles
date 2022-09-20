# Garmin SDK path
if test -e $HOME/Library/Application\ Support/Garmin/ConnectIQ/current-sdk.cfg
  set -x GARMIN_SDK_PATH (cat $HOME/Library/Application\ Support/Garmin/ConnectIQ/current-sdk.cfg)
  set -g fish_user_paths "$GARMIN_SDK_PATH/bin" $fish_user_paths
end
