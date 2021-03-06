#!/bin/sh

# http://fredkschott.com/post/2014/02/git-log-is-so-2005/
git config --global alias.d "diff"
git config --global alias.dc "diff --cached"
git config --global alias.dw "diff --word-diff=color"
git config --global alias.dcw "diff --word-diff=color --cached"
git config --global alias.dwc "diff --word-diff=color --cached"
git config --global alias.l "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.lg "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.lm "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit master..."
git config --global alias.lo "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit origin/HEAD..."
git config --global alias.lgm "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit master..."
git config --global alias.standup "log --color --pretty=format:'%Cred%h%Creset -%Creset %s %Cgreen(%cD) %C(bold blue)<%an>%Creset' --since='1 week ago' --author gchiam"

git config --global alias.br "branch"
git config --global alias.cbr "rev-parse --abbrev-ref HEAD"
git config --global alias.co "checkout"
git config --global alias.master "checkout master"
git config --global alias.ms "checkout master"
git config --global alias.ci "commit"
git config --global alias.pl "pull"
git config --global alias.s "status -s"
git config --global alias.sm "submodule"
git config --global alias.st "status"
git config --global alias.unstage "reset HEAD --"

git config --global alias.last "log -1 HEAD"

git config --global diff.tool "vimdiff"
git config --global difftool.prompt "no"

git config --global pager.diff "diff-so-fancy | less --tabs=8 -RFX"
git config --global pager.show "diff-so-fancy | less --tabs=8 -RFX"
