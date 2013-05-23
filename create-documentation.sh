#!/bin/sh

# All documentation should either go in the executable file as part of the --help option 
# or in the help2man.include file.  This script then will parse that information to 
# create the manual page
# Do not edit the *.1 files explicilty. Let this script create them as part of the packaging process.

for path in $(ls scripts/pkgit*|grep -v ~); do
    script=$(basename $path)
    echo Creating documentation for $script
    if [ -e $script.help2man.include ]; then
        extra_includes="--include=$script.help2man.include"
    else
        extra_includs=""
    fi
    help2man --output=$script.1 --no-info $extra_includes $path
done    

