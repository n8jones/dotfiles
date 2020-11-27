function fish_right_prompt
  set_color brblack
  type fish_vcs_prompt > /dev/null 2>&1; and fish_vcs_prompt
  set_color normal
end
