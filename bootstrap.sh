#!/bin/zsh

echo "dotfiles bootstraping..."

# load functions
export DIR_DOTFILES="$( cd "$( dirname "${0}" )"/ && pwd )"
for file in $DIR_DOTFILES/functions/*; do
  [ -r "$file" ] && [ -f "$file" ] && . "$file"
  echo "loading file $file"
done
unset file

# administrator
echo_title "Please, type your password"
sudo -v

# updating from github
echo_title_update "dotfiles"
#git pull origin master

doIt() {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "functions/" --exclude "functions.sh" --exclude "README.md" -av --no-perms . ~
    source ~/.zshrc
}

if [ "$1" = "--force" ]
then
    echo_info "overwriting existing files in $HOME"
    doIt
else
    read -q "REPLY?This may overwrite existing files in your home directory. Are you sure? (y/n)"
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo_info "overwriting existing files in $HOME"
        doIt
    else
        echo "continue without updating dotfiles in $HOME"
    fi
fi
unset doIt

# set OS X
echo_title "Configure OS X"
source .osxdefaults

# set brew apps
echo_title "Brew update, upgrade and install"
source .brew

# set npm
echo_title_installupdate "NPM packages"

typeset -A PACKAGES
PACKAGES=(
"mocha"
"nodemon"
)

for PKG in ${(k)PACKAGES}; do
    if [ "$FULLFIRE" = "true" ] || ! type ${PACKAGES[$PKG]} > /dev/null; then
        npm i -g $PKG
    fi
done


