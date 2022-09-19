# iTerm2 shell integration
if status --is-interactive
  set iterm2_shell_integration_file $HOME/.iterm2_shell_integration.fish
  if [ -f $iterm2_shell_integration_file ]
    source $iterm2_shell_integration_file
  end
end
