setup_gitconfig_local () {
  local gitconfigLocalFile="$HOME/.gitconfig.local"
  touch $gitconfigLocalFile

  local gitName="$(git config user.name)"
  local userFullName="$(id -F)"
  local defaultName="${gitName:-$userFullName}"
  ask "Set Git name" "$defaultName"
  local name=$(get_answer)

  git config --replace-all --file $gitconfigLocalFile user.name "$name"
  print_success "Set Git name to $name"

  local defaultEmail="$(git config user.email)"
  ask "Set Git email" "$defaultEmail"
  local email=$(get_answer)
  git config --replace-all --file $gitconfigLocalFile user.email "$email"
  print_success "Set Git email to $email"
}
