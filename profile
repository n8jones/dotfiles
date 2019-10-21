# vim: set filetype=sh :
echo 'Applying profile'

export PATH="/usr/local/bin:$PATH"

export GREP_OPTIONS="--color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} -I"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

command -v lsd &> /dev/null && alias ls=lsd

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jonesn7/.sdkman"
[[ -s "/Users/jonesn7/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jonesn7/.sdkman/bin/sdkman-init.sh"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

