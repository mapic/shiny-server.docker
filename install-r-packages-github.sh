#!/bin/bash

echo "Installing R packages from Github..."

while read F  ; do

    if [ -z "$F" ]; then
        echo "Skipping empty line..."
    else
    
        # install package
        echo "Installing $F..."
        sudo su - -c "R -e \"library('devtools'); install_github('${F}')\""
        
        # check for errors
        EXITCODE=$?
        echo "EXITCODE: $EXITCODE"
        if [ "$EXITCODE" -gt "0" ]; then
            echo "Some error occurred when installing package $F..."
            echo "Quitting!"
            exit 1 # debug
        else    
            clear
            echo ""
            echo "$F installed successfully..."
            echo ""
        fi

    fi

done <$1
