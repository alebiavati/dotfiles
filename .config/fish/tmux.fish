function t -a session_name -d "tmux shorthand to open new sessions"
  if test -n "$session_name"
    tmux attach -t $session_name || tmux new -s $session_name
  else
    tmux attach || tmux new -s main
  end
end

function tmux_init -d "Open a tmux session if none are attached already"
  # check we are not in TMUX
  if ! test -n "$TMUX"
    # check if there are any open sessions
    set tmux_ls_output (tmux ls ^ /dev/null)
    if test -n "$tmux_ls_output"
      # yes there are open sessions
      # check that none of them are attached
      if ! string match -q -- "*attached*" "$tmux_ls_output"
        # no sessions are attached, let's attach!
        tmux attach
      end
    else
      # no sessions, open a new one!
      tmux new -s main
    end
  end
end

# run TMUX init
tmux_init
