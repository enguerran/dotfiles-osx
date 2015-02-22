#!/bin/zsh

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="kphoen"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew npm osx)

source $ZSH/oh-my-zsh.sh

# add your var env in ~/.exports and your aliases in ~/.aliases
for file in ~/.{exports,aliases}
do
    [ -r "$file" ] && source "$file"
done
unset file

export PATH="$HOME/bin:/usr/local/bin:$PATH"

. `brew --prefix`/etc/profile.d/z.sh
