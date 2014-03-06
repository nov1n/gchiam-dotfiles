#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

ln -snvf $HOME/projects/gchiam-dotfiles $DOTFILES_DIR

ln -snvf $DOTFILES_DIR/.bashrc $HOME
ln -snvf $DOTFILES_DIR/.bash_profile $HOME
ln -snvf $DOTFILES_DIR/.bash_aliases $HOME
ln -snvf $DOTFILES_DIR/.bash_exports $HOME
ln -snvf $DOTFILES_DIR/.zshrc $HOME
ln -snvf $DOTFILES_DIR/.oh-my-zsh $HOME
ln -snvf $DOTFILES_DIR/.django_bash_completion $HOME
ln -snvf $DOTFILES_DIR/.dircolors $HOME
ln -snvf $DOTFILES_DIR/.tmux.conf $HOME
ln -snvf $DOTFILES_DIR/.vim $HOME
ln -snvf $DOTFILES_DIR/.vimrc $HOME
ln -snvf $DOTFILES_DIR/powerline-shell.py $HOME

test -d $HOME/.config || mkdir -p $HOME/.config
for f in `find $DOTFILES_DIR/.config -mindepth 1 -maxdepth 1`
do
    ln -snvf $f $HOME/.config/
done