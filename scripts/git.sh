setup_gitconfig_local () {
  local gitconfigLocalFile="$HOME/.gitconfig.local"
  touch $gitconfigLocalFile

  local gitName="$(git config user.name)"

  if ! test -n "$gitName"; then
    local userFullName="$(id -F)"
    ask "Set Git name" "$userFullName"
    gitName=$(get_answer)
    git config --replace-all --file $gitconfigLocalFile user.name "$gitName"
  fi

  print_success "Set Git name to $gitName"

  local gitEmail="$(git config user.email)"

  if ! test -n "$gitEmail"; then
    ask "Set Git email"
    gitEmail=$(get_answer)
    git config --replace-all --file $gitconfigLocalFile user.email "$gitEmail"
  fi

  print_success "Set Git email to $gitEmail"
}
