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

def --wrapped e [...args] {
    ^$env.EDITOR ...$args
}

# A wrapper for ripgrep (`rg`) that returns results as a structured table.
#
# This command calls the external `rg` command with the `--json` flag and parses the
# output into a Nushell table.
def --wrapped rg [
        --data # Include RipGrep data record
        ...args # All RipGrep arguments
    ]: nothing -> table<path:string, line:int,  text:string, data:record> {
    let color = ansi $env.config.color_config.search_result
    let reset = ansi reset
    ^rg --json ...$args |
        from json --objects |
        where type == "match" |
        get data |
        each {|d|
            let text = $d.lines.text
            let state = $d.submatches |
                reduce -f { pieces: [], last_index: 0} {|m s|
                    let pre = ($text | str substring ($s.last_index)..<($m.start))
                    let hl = $"($color)($m.match.text)($reset)"
                    {
                        pieces: ($s.pieces | append $pre | append $hl),
                        last_index: $m.end
                    }
                }
            let highlighted_text = $state.pieces |
                append ($text | str substring ($state.last_index)..) |
                str join |
                str trim
            let row = {
                path: $d.path.text,
                line: $d.line_number,
                text: $highlighted_text,
            }
            if $data {
                $row | insert data $d
            } else {
                $row
            }
        }
}

overlay use starship.nu
