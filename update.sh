#!/bin/zsh

# load functions (fi: echo_title, etc.)
echo "Loading toolkit"
export DIR_DOTFILES="$( cd "$( dirname "${0}" )"/ && pwd )"
for file in $DIR_DOTFILES/functions/*; do
  [ -r "$file" ] && [ -f "$file" ] && . "$file"
  echo "loading file $file"
done
unset file

echo_title "Bootstrap dotfiles update"

echo_title_install "dotfiles to home directory"
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "functions/" --exclude "resources/" --exclude "update.sh" --exclude "p4merge" --exclude "functions.sh" --exclude "README.md" -av --no-perms . ~
