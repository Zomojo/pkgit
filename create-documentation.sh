#!/bin/sh

# All documentation should either go in the executable file as part of the --help option 
# or in the help2man.include file.  This script then will parse that information to 
# create the manual page
# Do not edit the *.1 files explicilty. Let this script create them.

# Refuse to create documentation on an unclean repository
if [ $(git clean -d -n | wc -l) != 0 ]; then
    echo >&2 "Refusing to create the documentation on an unclean repository. git clean -d -n reports: "
    git clean -d -n 
    echo >&2 "Either commit the work, stash the work or clean up. The repository can be made clean by executing"
    echo >&2 "git clean -x -d -f"
    exit 1
fi

for path in $(ls scripts/pkgit-*|grep -v ~); do
    script=$(basename $path)
    echo Creating documentation for $script
    if [ -e $script.help2man.include ]; then
        extra_includes="--include=$script.help2man.include"
    else
        extra_includs=""
    fi
    help2man --output=$script.1 --no-info $extra_includes $path
done    

