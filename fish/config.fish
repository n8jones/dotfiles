set -gx GPG_TTY (tty)
set -x PATH ~/bin/groovy/bin:$PATH


which lsd >> /dev/null; and alias ls=lsd


# Setting PATH for Python 3.11
# The original version is saved in /Users/jonesn7/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"
