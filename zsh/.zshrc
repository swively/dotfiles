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
alias upgrade_my_fucking_plugin='git mast && git pom && cd frontend && yarn install && yarn build && cd .. && ./gradlew pluginUpgrade'

alias deathtoservers='kill -9 $(lsof -i tcp:3000 -t)'

export PATH="/usr/local/bin:/home/mike/bin:/usr/local/opt/postgresql@16/bin:/bin:$PATH"

source ~/.zsh/utils.zsh
source ~/.zsh/prompt.zsh

# enable chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-3.1.0

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && \. "/usr/local/opt/nvm/etc/bash_completion"
