#!/bin/bash

show_help() {
  cat << EOF >&2
note.sh [options] <arguments>
  -h | -?  Print this help
actions:
  -N       New note
  -E       Edit note
  -S       Search for notes
EOF
}

new_note() {
  id=$(uuidgen)
  created_date=$(date "+%Y-%m-%d %H:%M")
  cat << EOF
id: $id
title: $title
created_date: $created_date
---
$message
EOF
}

while getopts "h?NESt:" opt; do
  case "$opt" in
    h|\?)
      show_help
      exit 0
      ;;
    N) action=new
      ;;
    E) action=edit
      ;;
    S) action=search
      ;;
    t) title=$OPTARG
      ;;
  esac
done

if [ -z "$action" ]
then
  >&2 echo "You must specify an action."
  show_help
  exit 1
fi

shift $((OPTIND-1))
message=$@

echo "action: $action, title: $title, message: $message"
case "$action" in
  new) new_note
    ;;
esac
