# Composer path
if test -e $HOME/.composer/vendor/bin
  set -g fish_user_paths "$HOME/.composer/vendor/bin" $fish_user_paths
end
