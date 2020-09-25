function ls --description "alias ls; use lsd if available"
  set ls_actual (which lsd; or which ls)
  $ls_actual --color $argv
end
