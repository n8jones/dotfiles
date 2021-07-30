set -gx GPG_TTY (tty)
set -x JDTLS_JAR ~/src/3rd/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar
set -x JDTLS_CONFIG ~/src/3rd/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac
set -x JDTLS_WORKSPACE ~/eclipse-workspace/jdt-ls
set -x GROOVYLS_JAR ~/src/3rd/groovy-language-server/build/libs/groovy-language-server-all.jar


which lsd >> /dev/null; and alias ls=lsd

