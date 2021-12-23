#!/bin/bash
# $1 argument is home directory

if [ -z "$1" ]
then
	homedir="$HOME"
else
	homedir="$1"
fi

homedir=$(readlink -f "$homedir")

scriptdir=$(dirname "$0")

echo "$homedir"

workdir=$(readlink -f .)

cd "$homedir" || { echo "Can't enter '$homedir'" 1>&2; exit 1; } 

echo "performing backup of existing dot files"

datestamp=$(date "+%F_%H%M%S")

tar -czvf "rc-$datestamp.tgz" ".bashrc" ".inputrc" ".screenrc" ".vimrc"

readlink -f "rc-$datestamp.tgz"

cd "$workdir" || { echo "Can't enter '$workdir'" 1>&2; exit 1; } 

echo "performing copying of dot files"

cat "$scriptdir/bashrc" >> "$homedir/.bashrc"
cat "$scriptdir/inputrc" >> "$homedir/.inputrc"
cp "$scriptdir/screenrc" "$homedir/.screenrc"
cp "$scriptdir/vimrc" "$homedir/.vimrc"

exit 0
