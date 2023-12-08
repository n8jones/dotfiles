#!/bin/sh

date_time() {
  date '+%Y-%m-%d %H:%M'
}

bg1='blue'
fg1='black'
bg2='red'
fg2='black'
sep=' '
echo "#[fg=$bg1]$sep#[fg=$fg1,bg=$bg1] $(hostname) #[fg=$bg2]$sep#[fg=$fg2,bg=$bg2] $(date_time) "
