setopt histignorealldups sharehistory

# Use vim keybindings in shell
set -o vi
# use vim as default editor (i.e for bundle open __ )
export EDITOR=vi
export VISUAL=vi

export BROWSER="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# Fix escape delay
KEYTIMEOUT=1

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


alias ls="ls --color=auto"
alias lsa="ls -al"
alias be="bundle exec"
alias gpf="git push --force-with-lease origin "
alias gcom="git commit --verbose"
alias gcomv="git commit --verbose --no-verify"
alias wipit="git add -u; git commit --no-verify -m 'wip'"
alias rebon="git add -u; git rebase --continue"
alias tmux="tmux -2"
alias gpum="git pull upstream master"
alias gcb="git checkout -b "
alias gco="git checkout "
alias berc="be rails c"
alias gpfb="git push --force-with-lease origin `git rev-parse --abbrev-ref HEAD`"
alias gca='git commit --amend --no-edit'
alias delete_merged_branches='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'

alias deathtoservers='kill -9 $(lsof -i tcp:3000 -t)'

alias awshit="source ~/.juul/aws-environment.sh"
alias stage-console="switch-acct dev; env-secrets-manager --secret-id staging/juulio/devreadonly/v1 bundle exec rails c"
alias prod-console="switch-acct prod; env-secrets-manager --secret-id prod/juulio/devreadonly/v1 bundle exec rails c"

alias migos="be rake db:migrate; be rake db:test:prepare"

function agac() {
  ag "$1" app/javascript/apps/account/
}


export PATH="/usr/local/bin:/home/mike/bin:/usr/local/opt/postgresql@9.6/bin:/bin:$PATH"

source ~/.zsh/utils.zsh
source ~/.zsh/prompt.zsh

eval "$(direnv hook zsh)"
eval "$(nodenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/node@12/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="/usr/local/opt/node@14/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
