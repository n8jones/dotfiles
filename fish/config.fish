set -gx GPG_TTY (tty)
set -x JDTLS_JAR ~/DEC/c2imera/3rd/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar
set -x JDTLS_CONFIG ~/DEC/c2imera/3rd/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac
set -x JDTLS_WORKSPACE ~/eclipse-workspace/jdt-ls
set -x GROOVYLS_JAR ~/c2imera/3rd/groovy-language-server/build/libs/groovy-language-server-all.jar
set -x PATH ~/bin/groovy/bin:$PATH


which lsd >> /dev/null; and alias ls=lsd


# Setting PATH for Python 3.11
# The original version is saved in /Users/jonesn7/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"
