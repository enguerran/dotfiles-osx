#!/bin/zsh

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export PATH="./node_modules/.bin:$HOME/bin:/usr/local/bin:$PATH"

# add your var env in ~/.exports and your aliases in ~/.aliases
for file in ~/.{exports,aliases}
do
    [ -r "$file" ] && source "$file"
done
unset file

# Set name of the theme to load.
#ZSH_THEME="kphoen"
ZSH_THEME="agnoster"
DEFAULT_USER="enguerran"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git archlinux npm common-aliases docker tmux brew osx)

source $ZSH/oh-my-zsh.sh
source /usr/share/nvm/init-nvm.sh

PROMPT=$PROMPT'%{$fg[green]%}🐐 💨 %{$reset_color%} '

###-tns-completion-start-###
if [ -f /home/enguerran/.tnsrc ]; then 
    source /home/enguerran/.tnsrc 
fi
###-tns-completion-end-###

[[ -r "brew" ]] && . `brew --prefix`/etc/profile.d/z.sh
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
#. /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh
