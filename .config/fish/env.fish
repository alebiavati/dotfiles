set -x CODE_DIR "$HOME/code"
set -x DOTFILES_DIR "$CODE_DIR/.dotfiles"

if test -d $CODE_DIR/.traefik
  set -x TRAEFIK_DIR "$CODE_DIR/.traefik"
end

if test -e /usr/libexec/java_home
  set -x JAVA_HOME (/usr/libexec/java_home)
end

# set PATH
set my_paths \
  $TRAEFIK_DIR/bin \
  $HOME/bin \
  $HOME/.local/bin \
  $HOME/.composer/vendor/bin \
  (cat $HOME/Library/Application\ Support/Garmin/ConnectIQ/current-sdk.cfg)bin

set missing_paths
for my_path in $my_paths
  if not echo $PATH | grep $my_path > /dev/null 2> /dev/null
    if test -d $my_path
      set missing_paths $missing_paths $my_path
    end
  end
end

set -x PATH $missing_paths $PATH

# Mono Path setting
set -x VSToolsPath /Library/Frameworks/Mono.framework/Versions/Current/lib/mono/xbuild/Microsoft/VisualStudio/v16.0/

# Go path
set -x GOPATH $HOME/.go
set -x PATH $GOPATH/bin $PATH

# GPG env
set -x GPG_TTY (tty)
