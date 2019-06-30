#!/bin/bash

p () {
  printf "\n\033[1m\033[34m%s\033[0m\n\n" "${1}"
}

ask () {
  print_question "$1 [$2] "
  read
  REPLY=${REPLY:-$2}
}

ask_for_confirmation() {
    print_question "$1 (Y/n) "
    read -n 1
    test "${REPLY:-}" != "" && printf "\n"
    REPLY="${REPLY:-Y}"
}

answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

cmd_exists() {
    [ -x "$(command -v "$1")" ] \
        && printf 0 \
        || printf 1
}

is_app_installed() {
  type "$1" &>/dev/null
}

execute() {
    $1
    print_result $? "${2:-$1}"
}

get_answer() {
    printf "$REPLY"
}

get_os() {

    declare -r OS_NAME="$(uname -s)"
    local os=""

    if [ "$OS_NAME" == "Darwin" ]; then
        os="osx"
    elif [ "$OS_NAME" == "Linux" ] && [ -e "/etc/lsb-release" ]; then
        os="ubuntu"
    fi

    printf "%s" "$os"

}

is_git_repository() {
    [ "$(git rev-parse &>/dev/null; printf $?)" -eq 0 ] \
        && return 0 \
        || return 1
}

mkd() {
    if [ -n "$1" ]; then
        if [ -e "$1" ]; then
            if [ ! -d "$1" ]; then
                print_error "$1 - a file with the same name already exists!"
            else
                print_success "$1"
            fi
        else
            execute "mkdir -p $1" "$1"
        fi
    fi
}

print_error() {
    # Print output in red
    printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}

print_info() {
    # Print output in purple
    printf "\n\e[0;35m $1\e[0m\n\n"
}

print_question() {
    # Print output in yellow
    printf "\e[0;33m  [?] $1\e[0m"
}

print_result() {
    if [ $1 -eq 0 ]; then
      print_success "$2"
    else
      print_error "$2"
      exit $1
    fi
}

print_success() {
    # Print output in green
    printf "\e[0;32m  [✔] $1\e[0m\n"
}
