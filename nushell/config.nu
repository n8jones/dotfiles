$env.config.show_banner = false
$env.config.edit_mode = 'vi'

if $nu.os-info.name == 'windows' and $env.TERM_PROGRAM? == 'WezTerm' {
    $env.config.shell_integration.osc133 = false
}

if $env.EDITOR? == null and (which nvim | is-not-empty) {
    $env.EDITOR = 'nvim'
}


def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

def --env e [...args] {
    ^$env.EDITOR ...$args
}

overlay use starship.nu
