# Kube config
if test -e $HOME/.kube/config
  set -x KUBE_CONFIG_PATH $HOME/.kube/config
  set -x KUBECONFIG $KUBE_CONFIG_PATH
end

# krew plugin manager
if test -e $HOME/.krew/bin
  set -g fish_user_paths "$HOME/.krew/bin" $fish_user_paths
end

# kubernetes
alias k="kubectl"
