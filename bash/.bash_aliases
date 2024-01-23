alias ll='exa -al --color=always --group-directories-first'

alias branch='git branch | grep "*" | awk '\''{print $2}'\'''
alias pullf='git pull --ff-only origin `branch`'
alias pull='git pull origin `branch`'
alias push='git push origin `branch`'
alias gpsa="git remote | xargs -I remotes git push remotes master"
# change branch interactively
alias cb='git checkout `git branch | fzf`'

# go to trash folder
alias cdt='cd ~/.local/share/Trash/files/'

# fetch possible updates
alias sync='sudo apt update; apt list --upgradable'
# upgrade system packages
alias upgrade='sudo apt upgrade'
