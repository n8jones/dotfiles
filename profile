# vim: set filetype=sh :
echo 'Applying profile'

export PATH="$HOME/.cargo/bin:$HOME/go/bin:/usr/local/bin:$PATH"

export GREP_OPTIONS="--color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} -I"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

command -v lsd &> /dev/null && alias ls=lsd

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jonesn7/.sdkman"
[[ -s "/Users/jonesn7/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jonesn7/.sdkman/bin/sdkman-init.sh"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf=:"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"

alias jekyll='docker run --rm -it -v "$PWD:/srv/jekyll" -v "/Users/jonesn7/dev/jekyll/bundle:/usr/local/bundle" -p "4000:4000" jekyll/builder jekyll'

alias drr='docker run --rm -it -v "$PWD:/current" -w "/current"'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

alias sv='tmux split-window -h nvim'

export PATH="/usr/local/opt/helm@2/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/eclipse/install:$PATH"
export EDITOR='nvim'

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    ssh-add
fi
export VAGRANT_EXPERIMENTAL="disks"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s "$HOME/.local/profile" ]] && source "$HOME/.local/profile"

