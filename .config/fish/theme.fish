# Suppress fish greeting
set fish_greeting

# Color Scheme for iTerm2 + tmux
if status --is-interactive
  set -x TERM xterm-256color

  # Theme options (Spacefish)
  # set SPACEFISH_CHAR_SYMBOL "❯"
  # set SPACEFISH_USER_SHOW "always"
  # set SPACEFISH_HOST_SHOW "always"
  # set SPACEFISH_HOST_PREFIX "on "
  # set SPACEFISH_DIR_PREFIX "at "

  # # Different levels of prompt details
  # set SPACEFISH_PROMPT_ORDER_ALL time user host dir git package node ruby golang php rust haskell julia elixir docker aws venv conda pyenv dotnet kubecontext exec_time line_sep battery vi_mode jobs exit_code char
  # set SPACEFISH_PROMPT_ORDER_COMMON user host dir git package node ruby golang php elixir docker pyenv kubecontext line_sep jobs char
  # set SPACEFISH_PROMPT_ORDER_NODE user host dir git package node line_sep jobs char
  # set SPACEFISH_PROMPT_ORDER_BASIC user host dir git line_sep jobs char

  # # Set your default
  # set SPACEFISH_PROMPT_ORDER $SPACEFISH_PROMPT_ORDER_BASIC

  if type -q "starship"
    starship init fish | source
  end
end
