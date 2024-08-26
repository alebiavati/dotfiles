# Android Home
if test -e $HOME/Library/Android/sdk
  set -x ANDROID_HOME $HOME/Library/Android/sdk
  set -g fish_user_paths $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $fish_user_paths
end
