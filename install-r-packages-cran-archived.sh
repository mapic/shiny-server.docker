#!/bin/bash

while read F  ; do

    if [ -z "$F" ]; then
        echo "Skipping empty line..."
    else

        # install package
        echo "Installing $F..."
        # https://stackoverflow.com/questions/25721884/how-should-i-deal-with-package-xxx-is-not-available-for-r-version-x-y-z-wa
        sudo su - -c "R -e \"devtools::install_url('${F}')\""

        # check for errors
        EXITCODE=$?
        echo "EXITCODE: $EXITCODE"
        if [ "$EXITCODE" -gt "0" ]; then
            echo "Some error occurred when installing package $F..."
            echo "Quitting!"
            exit 1
        else
            clear
            echo ""
            echo "$F installed successfully..."
            echo ""
        fi
    fi

done <$1

