# Navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end

# Networking. IP address, dig, DNS
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias dig="dig +nocmd any +multiline +noall +answer"
# wget sucks with certificates. Let's keep it simple.
alias wget="curl -O"

# Recursively delete `.DS_Store` files
alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"

# Update installed Ruby gems, Homebrew, npm, and their installed packages
alias brew_update="brew -v update; brew upgrade --force-bottle --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor;"

# CD to the dotfiles
alias dotfiles="cd $DOTFILES_DIR"

# reload config
alias reload="source ~/.config/fish/config.fish"

# Dorcker
alias docker-stop-all-containers="docker stop (docker ps -a -q)"
alias docker-rm-all-containers="docker rm (docker ps -a -q)"
alias docker-rm-all-images="docker rmi (docker images -a -q)"
alias docker-rm-all-volumes="docker volume rm (docker volume ls -f dangling=true -q)"
# alias docker-reset="(docker-stop-all-containers > /dev/null 2>&1) && (docker-rm-all-containers > /dev/null 2>&1) && (docker-rm-all-images > /dev/null 2>&1) && (docker-rm-all-volumes > /dev/null 2>&1)"

# Verdaccio
alias verdaccio="docker run -d -it --rm --name verdaccio -p 4873:4873 verdaccio/verdaccio"
