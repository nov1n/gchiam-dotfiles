#!/bin/sh

# http://fredkschott.com/post/2014/02/git-log-is-so-2005/
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

git config --global alias.br 'branch'
git config --global alias.co 'checkout'
git config --global alias.ci 'commit'
git config --global alias.st 'status'
git config --global alias.unstage 'reset HEAD --'

git config --global alias.last 'log -1 HEAD'

git config --global diff.tool 'vimdiff'
git config --global difftool.prompt 'no'