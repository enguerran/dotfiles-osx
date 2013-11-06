From [Setting Up a Mac Dev Machne From Zero to Hero With Dotfiles](http://net.tutsplus.com/tutorials/tools-and-tips/setting-up-a-mac-dev-machine-from-zero-to-hero-with-dotfiles/) by [Simon Owen](http//sow.so) with tips of [MoOx dotfiles](https://github.com/MoOx/dotfiles)

How does it work?
---
Bootstrap will:

- sync the local repo and the GitHub one,
- then copy those files to your home folder overriding any existing files (y/n),
- then set configuration for OS X,
- then update/upgrade/install brew, brew-cask, npm

How do I launch it?
---
```
$ .bootstrap.sh
```