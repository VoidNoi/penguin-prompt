#!/bin/zsh

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git 

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst


zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# 
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[red]%} %b%{$fg[blue]%})%{$reset_color%}%"

PROMPT="%B 🐧 %{$fg[magenta]%}%c%{$reset_color%}%(?:%{$fg_bold[blue]%}:%{$fg_bold[red]%})%"
PROMPT+="\$vcs_info_msg_0_ "
PROMPT+="%B%{$fg[cyan]%}❯ "
