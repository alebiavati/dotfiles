set -x CODE_DIR "$HOME/code"
set -x DOTFILES_DIR "$CODE_DIR/.dotfiles"
set -x TRAEFIK_DIR "$CODE_DIR/.traefik"
set -x PATH "$HOME/bin:$HOME/.local/bin:$HOME/.composer/vendor/bin:$TRAEFIK_DIR/bin:$PATH"
