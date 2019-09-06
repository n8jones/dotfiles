#!/bin/bash
# vim: set filetype=sh :

export PATH="/usr/local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias ls='ls -G'

export PS1='\[\e[1;32m\]\u\[\e[1;35m\]@\[\e[1;32m\]\h \[\e[1;33m\]\w \e[0;34m\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\n\[\e[1;36m\]$\[\e[0m\] '

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

source <(kubectl completion bash)
source ~/.completions.d/minikube-completion


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jonesn7/.sdkman"
[[ -s "/Users/jonesn7/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jonesn7/.sdkman/bin/sdkman-init.sh"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

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

