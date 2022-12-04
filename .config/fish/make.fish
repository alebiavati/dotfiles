# update make path
if test -e /usr/local/opt/make/libexec/gnubin
  set -g fish_user_paths "/usr/local/opt/make/libexec/gnubin" $fish_user_paths
end

if test -e /opt/homebrew/opt/make/libexec/gnubin
  set -g fish_user_paths "/opt/homebrew/opt/make/libexec/gnubin" $fish_user_paths
end
