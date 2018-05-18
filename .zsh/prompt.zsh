autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr '%F{2}⊕'
zstyle ':vcs_info:*' unstagedstr '%F{1}⊘'
zstyle ':vcs_info:git*' formats '%F{8}[%F{4}%b%u%c%F{8}]'
zstyle ':vcs_info:git*' actionformats '%F{8}[%F{4}%b%u%c%F{8}|%F{2}%a%F{8}]'
precmd() { vcs_info }

setopt promptsubst

local suspended_jobs="%F{17}%(1j. %j.)%f"
local root_prompt="%F{1}▲"
local user_prompt="%(?.%F{20}△.%F{1}▽)"

PROMPT='%F{5}%n%F{15}@%F{3}%m%F{15}:%F{6}%1~${vcs_info_msg_0_}${suspended_jobs} %(!.${root_prompt}.${user_prompt})%f%k%b '
