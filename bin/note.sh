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
  id=$(uuidgen | tr '[:upper:]' '[:lower:]')
  created_date=$(date "+%Y-%m-%d %H:%M")
  tmpFile=`mktemp`
  cat << EOF >> $tmpFile
# vim: set filetype=yaml:
id: $id
title: $title
created_date: $created_date
---
$message
EOF
  vim $tmpFile
  if [ $? -eq 0 ]
  then
    if [ -z "$folder" ]
    then
      folder=$(date "+%Y/%m/%d")
    fi
    noteFile="$notebook/$folder/"
    mkdir -p "$noteFile"
    fileTitlePortion=$(yq r $tmpFile 'title' | tr '[:upper:]' '[:lower:]' | perl -p -e "s/'|\s+$|^\s+//g" | perl -p -e 's/\b(a|an|the)\b/ /g' | tr -sC '[:alnum:]' '-')
    if [ ! -z "$fileTitlePortion" ]
    then
      noteFile="$noteFile${fileTitlePortion:0:25}-"
    fi
    noteFile="$noteFile${id:0:5}.note.yaml"
    mv "$tmpFile" "$noteFile"
  else
    rm "$tmpFile"
  fi
}

while getopts "h?NESt:b:f:" opt; do
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
    b) notebook=$OPTARG
      ;;
    f) folder=$OPTARG
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

if [ -z "$notebook" ]
then
  if [ -z "$NOTEBOOK" ]
  then
    notebook=$(pwd)
  else
    notebook=$NOTEBOOK
  fi
fi

echo "action: $action, notebook: $notebook, title: $title, message: $message"
case "$action" in
  new) new_note
    ;;
esac
