setup_gitconfig_local () {
  local gitconfigLocalFile="$HOME/.gitconfig.local"
  touch $gitconfigLocalFile

  local gitName="$(git config user.name)"

  if test -n $gitName; then
    local userFullName="$(id -F)"
    ask "Set Git name" "$defaultName"
    local name=$(get_answer)
    git config --replace-all --file $gitconfigLocalFile user.name "$name"
  fi

  print_success "Set Git name to $name"

  local gitEmail="$(git config user.email)"

  if test -n $gitEmail; then
    ask "Set Git email"
    local email=$(get_answer)
    git config --replace-all --file $gitconfigLocalFile user.email "$email"
  fi

  print_success "Set Git email to $email"
}
