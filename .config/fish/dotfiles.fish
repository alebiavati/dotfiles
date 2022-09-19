# Dotfiles path
if test -e $HOME/code/.dotfiles
  set -x DOTFILES_DIR "$HOME/code/.dotfiles"
end

# dotfile installed bin folder
if test -e $HOME/bin
  set -g fish_user_paths $HOME/bin $fish_user_paths
end

# CD to the dotfiles
alias dotfiles="cd $DOTFILES_DIR"
