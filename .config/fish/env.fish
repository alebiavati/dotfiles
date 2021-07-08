set -x CODE_DIR "$HOME/code"
set -x DOTFILES_DIR "$CODE_DIR/.dotfiles"
if test -d $CODE_DIR/.traefik
  set -x TRAEFIK_DIR "$CODE_DIR/.traefik"
end

# set PATH
set -g fish_user_paths \
  $TRAEFIK_DIR/bin \
  $HOME/bin \
  $HOME/.local/bin \
  $HOME/.composer/vendor/bin \
  /usr/local/opt/make/libexec/gnubin \
  (cat $HOME/Library/Application\ Support/Garmin/ConnectIQ/current-sdk.cfg)bin \
  $fish_user_paths

# Java Home
if test -e /usr/libexec/java_home
  set -x JAVA_HOME (/usr/libexec/java_home)
end

# Mono Path setting
set -x VSToolsPath /Library/Frameworks/Mono.framework/Versions/Current/lib/mono/xbuild/Microsoft/VisualStudio/v16.0/

# Go path
set -x GOPATH $HOME/.go
set -g fish_user_paths $GOPATH/bin $fish_user_paths

# GPG env
set -x GPG_TTY (tty)

# Homebrew sbin folder
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
