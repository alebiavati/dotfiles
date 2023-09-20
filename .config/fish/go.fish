# Go path
if test -e $HOME/go
  set -x GOPATH $HOME/go
  set -g fish_user_paths $GOPATH/bin $fish_user_paths
end
