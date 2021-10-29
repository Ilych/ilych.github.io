#!/bin/bash
# $1 argument is home directory

if [ -z "$1" ]
then
	homedir="$HOME"
else
	homedir="$1"
fi

homedir=$(readlink -f "$homedir")

echo "$homedir"

read -p "Do you want to update .rc files in '$homedir'? y/[n]: " updaterc_yn

if [ "$updaterc_yn" == "y" ]
then
	cp -v "$homedir/.bashrc" "$homedir/.bashrc.bak"
	cat bashrc >> "$homedir/.bashrc"
	cp -v "$homedir/.inputrc" "$homedir/.inputrc.bak" 
	cat inputrc >> "$homedir/.inputrc"
	cp -v "$homedir/.screenrc" "$homedir/.screenrc.bak"
	cp -v screenrc "$homedir/.screenrc"
	cp -v "$homedir/.vimrc" "$homedir/.vimrc.bak"
	cp -v vimrc "$homedir/.vimrc"
fi

exit 0
