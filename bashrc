#!/bin/bash
# sohooo dotfiles

# -----------------------------------------------------------
# PATHS
# -----------------------------------------------------------

# homebrew binaries
export PATH=/usr/local/bin:$PATH

# -----------------------------------------------------------
# ENVIRONMENT
# -----------------------------------------------------------
set -o vi

# disable that mail sh*t
unset MAILCHECK

# colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# -----------------------------------------------------------
# ALIASES / FUNCTIONS
# -----------------------------------------------------------

alias tree="find . -print | sed -e 's;[^/]*/;|-- ;g;s;-- |;   |;g'"
alias gl='git log --pretty=oneline --abbrev-commit'
alias du1='du -h --max-depth=1'
alias fn='find . -name'
alias hi='history | tail -20'

# -----------------------------------------------------------
# GIT PROMPT [credits: http://gist.github.com/31934]
# -----------------------------------------------------------
      BLACK="\[\033[0;30m\]"
       BLUE="\[\033[0;34m\]"
 LIGHT_BLUE="\[\033[1;34m\]"
	    RED="\[\033[0;31m\]"
  LIGHT_RED="\[\033[1;31m\]"
      GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
     YELLOW="\[\033[1;33m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

function parse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
    state="${RED}!"
  fi
  
  # set git author prompt, or nothing
  if [[ "x${GIT_AUTHOR_NAME}" == "x" ]]; then
    git_author=""
  else
    git_author="${GIT_AUTHOR_NAME}@"
  fi

  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}↑"
    else
      remote="${YELLOW}↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " ($git_author${branch})${remote}${state}"
  fi
}

function prompt_func() {
    previous_return_value=$?;
    # prompt="${TITLEBAR}$BLUE[$RED\w$GREEN$(__git_ps1)$YELLOW$(git_dirty_flag)$BLUE]$COLOR_NONE "
    # prompt="\u@\h ${TITLEBAR}${BLUE}[${RED}\w${GREEN}$(parse_git_branch)${BLUE}]${COLOR_NONE} "
    prompt="\u@\h ${TITLEBAR}${BLUE}[\w${LIGHT_BLUE}$(parse_git_branch)${BLUE}]${COLOR_NONE} "
    if test $previous_return_value -eq 0
    then
        PS1="${prompt}\n${BLUE}%${COLOR_NONE} "
    else
        PS1="${prompt}\n${RED}!${COLOR_NONE} "
    fi
}

PROMPT_COMMAND=prompt_func

# This loads RVM into a shell session.
[[ -s "/Users/soho/.rvm/scripts/rvm" ]] && source "/Users/soho/.rvm/scripts/rvm"
