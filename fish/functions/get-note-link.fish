function get-note-link --description 'Get the link text for a note'
  set files $argv
  if test (count $files) -eq 0
   set files '-g' '*.md'
  end
  rg -m 1 --vimgrep '# +([^ ].+)' -r '$1' $files \
    | awk -F : '{ print "[[" substr($1, 0, length($1)-3) "|" $4 "]]" }' \
    | fzf -1
end
