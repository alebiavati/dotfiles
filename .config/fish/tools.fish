if status --is-interactive
  # env commands init
  for env_command in nodenv pyenv # rbenv plenv
    if type -q $env_command
      and source ($env_command init -|psub)
    end
  end

  # Zoxide
  if type -q "zoxide"
    zoxide init fish | source
  end

  # direnv
  if type -q "direnv"
    set -x DIRENV_LOG_FORMAT ""
    direnv hook fish | source
  end
end
