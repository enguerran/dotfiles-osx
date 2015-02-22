#!/bin/zsh

# define zsh as default shell
if [ "$SHELL" = "/bin/zsh" ]
then
 echo "You're already using zsh"
else
 echo_install zsh
 chsh -s /bin/zsh $USER
 fi

# load functions (fi: echo_title, etc.)
echo "Loading toolkit"
export DIR_DOTFILES="$( cd "$( dirname "${0}" )"/ && pwd )"
for file in $DIR_DOTFILES/functions/*; do
  [ -r "$file" ] && [ -f "$file" ] && . "$file"
  echo "loading file $file"
done
unset file

echo_title "Bootstrap dotfiles installation"

# run the install
doIt() {
    # copy dotfiles to home directory
    echo_title_install "dotfiles to home directory"
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "functions/" --exclude "resources/" --exclude "updatedotfiles.sh" --exclude "p4merge" --exclude "functions.sh" --exclude "README.md" -av --no-perms . ~

    # configure zsh
    echo_title_install "oh-my-zsh and configure it"
    if [ -d ~/.oh-my-zsh ]
    then
        echo_user "write script to update oh-my-zsh"
    else
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
    source ~/.zshrc

    if ! type "ls_release" 2>/dev/null; then
        # linux

        # - sublime text 3 -
        git clone https://github.com/enguerran/sublimesettings.git $HOME/.config/sublime-text-3/Packages/User
    else
        # set OSX
        source ~/.osxdefaults

        # set brew
        echo_title_install Homebrew
        if ! type "brew" > /dev/null
        then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        else
            echo_success "Homebrew is already installed"
        fi
        source ~/.brew

    # install brew app
    brew install z
    brew install node
    brew install git

    # install applications
    brewcaskinstall "BitTorrent Sync"
    brewcaskinstall "Dash"
    brewcaskinstall "Dropbox"
    brewcaskinstall "Evernote"
    brewcaskinstall "Firefox"
    #brewcaskinstall "Firefox Nightly" "$HOME/Applications"
    #brewcaskinstall "Firefox Aurora" "$HOME/Applications"
    brewcaskinstall "iterm2"
    brewcaskinstall "Moom"
    brewcaskinstall "p4merge"
    brewcaskinstall "Spotify"
    brewcaskinstall "Steam"
    brewcaskinstall "Sublime Text3"
    brewcaskinstall "Vlc"

    # configure application
    # - sublime text 3 -
    git clone https://github.com/enguerran/sublimesettings.git $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    # - p4merge -
    mv ~/p4merge /usr/local/bin/p4merge
    chmod 775 /usr/local/bin/p4merge
}

# copy dotfile from local repo to home
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
        echo_info "continue without updating dotfiles in $HOME"
    fi
fi
unset doIt
