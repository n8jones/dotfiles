if $nu.os-info.name == 'windows' and $env.TERM_PROGRAM? == 'WezTerm' {
    $env.config.shell_integration.osc133 = false
}

overlay use starship.nu

def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}
