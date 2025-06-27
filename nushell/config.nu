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
#
# Usage:
# > rg <rg_flags> <pattern> <path>
#
# Parameters:
#   ...args: string - All arguments and flags to pass directly to the external `rg` command.
#
# Output:
#   A table with the following columns:
#   - path: The file path of the match.
#   - line: The line number of the match.
#   - start_min: The starting column of the first match on the line.
#   - end_max: The ending column of the last match on the line.
#   - text: The full text of the line with all matches highlighted.
#   - data: The original JSON data record from ripgrep for further inspection.
def --wrapped rg [...args]: nothing -> table<path:string, line:int, start_min:int, end_max:int, text:string, data:record> {
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
            {
                path: $d.path.text,
                line: $d.line_number,
                start_min: ($d.submatches | get start | math min),
                end_max: ($d.submatches | get end | math max),
                text: $highlighted_text,
                data: $d,
            }
        }
}

overlay use starship.nu
