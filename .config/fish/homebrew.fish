# Homebrew
if test -e "/usr/local/sbin"
  set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
end

if test -e "/opt/homebrew/bin"
  set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths
end

if test -e "/opt/homebrew/sbin"
  set -g fish_user_paths "/opt/homebrew/sbin" $fish_user_paths
end

if test -e "/opt/homebrew/opt/postgresql@15/bin"
  set -g fish_user_paths "/opt/homebrew/opt/postgresql@15/bin" $fish_user_paths
end
