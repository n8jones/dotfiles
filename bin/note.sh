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

while getopts "h?NES" opt; do
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
  esac
done

if [ -z "$action" ]
then
  >&2 echo "You must specify an action."
  show_help
  exit 1
fi

shift $((OPTIND-1))

echo "action: $action, leftovers: $@"
