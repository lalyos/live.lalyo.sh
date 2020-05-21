#!/usr/bin/env bash

debug() {
  [[ "$DEBUG" ]] && echo "-----> $*" 1>&2
}

replace-yt-link(){
    declare link=$1
    : ${link:? required}

    debug replace yt link to: $link
    gsed -i 's@embed/[^"]*@embed/'${link}'@' index.html
}

git-push() {
    debug press ENTER to proceed ...
    git commit --amend -a -C HEAD
    git push origin HEAD -f
}

main() {
  : ${DEBUG:=1}
  replace-yt-link "$@"
  git-push
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@" || true