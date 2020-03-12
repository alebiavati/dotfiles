set -x CODE_DIR "$HOME/code"
set -x DOTFILES_DIR "$CODE_DIR/.dotfiles"
set -x TRAEFIK_DIR "$CODE_DIR/.traefik"
set -x PATH "$TRAEFIK_DIR/bin:$HOME/bin:$HOME/.local/bin:$HOME/.composer/vendor/bin:$PATH"
