# Dorcker
alias docker-stop-all-containers="docker stop (docker ps -a -q)"
alias docker-rm-all-containers="docker rm (docker ps -a -q)"
alias docker-rm-all-images="docker rmi (docker images -a -q)"
alias docker-rm-all-volumes="docker volume rm (docker volume ls -f dangling=true -q)"
# alias docker-reset="(docker-stop-all-containers > /dev/null 2>&1) && (docker-rm-all-containers > /dev/null 2>&1) && (docker-rm-all-images > /dev/null 2>&1) && (docker-rm-all-volumes > /dev/null 2>&1)"

# Docker
# alias docker="docker"
alias d="docker"
alias dc="docker compose"

# Verdaccio
alias verdaccio="docker run -d -it --rm --name verdaccio -p 4873:4873 verdaccio/verdaccio"
