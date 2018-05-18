# Set up the prompt
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#autoload -Uz promptinit
#promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use vim keybindings in shell
set -o vi
# use vim as default editor (i.e for bundle open __ )
export EDITOR=vi
export VISUAL=vi

export BROWSER=google-chrome
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
eval "$(dircolors -b)"
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

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

alias ls="ls --color=auto"
alias lsa="ls -al"
alias be="bundle exec"
alias gpf="git push --force-with-lease origin "
alias gcom="git commit --verbose"
alias gcomv="git commit --verbose --no-verify"
alias wipit="git add .; git commit --no-verify -m 'wip'"
alias rebon="git add .; git rebase --continue"
alias tmux="tmux -2"
alias gpum="git pull upstream master"
alias gcb="git checkout -b "
alias gco="git checkout "
alias berc="be rails c"

xset r rate 200 80

export PATH=/home/mike/bin:$PATH

source ~/.zsh/utils.zsh
