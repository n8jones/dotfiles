#!/bin/bash
# vim: set filetype=sh :

export PS1='\[\e[1;32m\]\u\[\e[1;35m\]@\[\e[1;32m\]\h \[\e[1;33m\]\w \e[0;34m\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\n\[\e[1;36m\]$\[\e[0m\] '

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

source <(kubectl completion bash)
source ~/.completions.d/minikube-completion



###-begin-yo-completion-###
if type complete &>/dev/null; then
  _yo_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           yo-complete completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _yo_completion yo
fi
###-end-yo-completion-###

[[ -e ~/.profile ]] && source ~/.profile


export PATH="$HOME/.cargo/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
