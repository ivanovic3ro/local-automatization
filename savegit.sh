#!/bin/bash
my_route=$(pwd)
project=${my_route##*/}
current_branch=$(git branch --show-current)
#git_action=$(zenity --list \
#  --list \
#  --title="Action Git" \
#  --column="Type"\
#  --column 'Interface Name'\
#    TRUE Update \
#    FALSE Fix \
#    FALSE Advange \
#    FALSE Bug)
#    echo "$git_action"
echo $current_branch
branch=$(zenity --entry \
  --title="Branch" \
  --text="git branch:" \
  --entry-text "$current_branch")
if [ -z "$branch" ]; then
  exit 1
fi
# Define the list items
items=("Update" "Fix" "Advange" "Bug")
# Use Zenity to present the list
(
    sleep 0.2  # Give Zenity some time to open
    xdotool key Down
    xdotool key Up
) &
git_action=$(zenity --list \
    --title="Select an Item" \
    --column="Items" \
    "${items[@]}" \
    --height=300 \
    --width=400)
echo "Action: $git_action"

if [ -z "$git_action" ]; then
  exit 1
fi

description=$(zenity --entry \
  --title="description commit" \
  --text="description:" \
  --entry-text "")

if [ -z "$description" ]; then
  exit 1
fi
folder_commit=$(zenity --entry \
  --title="files to add" \
  --text="files:" \
  --entry-text ".")
  
if [ -z "$folder_commit" ]; then
  exit 1
fi
commit_text="${git_action}-${project^}-${description^}"
echo $folder_commit
echo $git_action
[ -z $folder_commit ]
if [ -n "$folder_commit" ] && [ -n "$git_action" ] && [ -n "$description" ]; then
  echo "execute git command"
  git status
  git add $folder_commit
  git commit -m "$commit_text"
  git pull origin $branch
  git push origin $branch
  echo "end execute git command into $branch"
fi
