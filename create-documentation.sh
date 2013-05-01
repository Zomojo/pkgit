#!/bin/dash

# All documentation should either go in the cake source file as part of the --help option 
# or in the help2man.include file.  This script then will parse that information to 
# create the manual page and the README file.  
# Do not edit cake.1 or README explicilty. Let this script create them.

# Refuse to create documentation on an unclean repository
if [ $(git clean -d -n | wc -l) != 0 ]; then
    echo >&2 "Refusing to create the documentation on an unclean repository. git clean -d -n reports: "
    git clean -d -n 
    echo >&2 "Either commit the work, stash the work or clean up. The repository can be made clean by executing"
    echo >&2 "git clean -x -d -f"
    exit 1
fi

for path in scripts/pkgit-*; do
    script=$(basename $path)
    echo $script
#    help2man --output=$SCRIPT.1 --no-info --include=$SCRIPT.help2man.include 
#    nroff -c -mandoc cake.1 | col -b > README
done    

