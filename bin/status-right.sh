#!/bin/sh

date_time() {
  date '+%Y-%m-%d %H:%M'
}

echo "#[fg=#ff7100]#[fg=default,bg=#ff7100] $(hostname) #[fg=#ce0079,bg=#ff7100]#[fg=default,bg=#ce0079] $(date_time) "
