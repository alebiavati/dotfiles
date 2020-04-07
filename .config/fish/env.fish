set -x CODE_DIR "$HOME/code"
set -x DOTFILES_DIR "$CODE_DIR/.dotfiles"
set -x TRAEFIK_DIR "$CODE_DIR/.traefik"
set -x JAVA_HOME (/usr/libexec/java_home)

# set PATH
set my_paths \
  $TRAEFIK_DIR/bin \
  $HOME/bin \
  $HOME/.local/bin \
  $HOME/.composer/vendor/bin

set missing_paths
for my_path in $my_paths
  if not echo $PATH | grep $my_path > /dev/null 2> /dev/null
    set missing_paths $missing_paths $my_path
  end
end

set -x PATH $missing_paths $PATH
