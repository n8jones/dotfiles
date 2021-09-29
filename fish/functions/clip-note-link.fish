function clip-note-link --description 'Clip the link text for a note to the clipboard'
get-note-link $argv | pbcopy
end
