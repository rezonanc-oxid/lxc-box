#!/bin/bash

function vagrant-ssh() {
    DIR=$(pwd)

    # find vagrant dir "above"
    while [ "$DIR" != "/" ]; do
        VAGRANT_DIR="$DIR"/.vagrant

        if [ -d "$VAGRANT_DIR" ]; then
            CACHE_FILE="$VAGRANT_DIR"/.ssh_config_cache

            if [ ! -f $CACHE_FILE ]; then
                CACHE_OUTPUT="$(vagrant ssh-config)"
                CACHE_OUTPUT_RC=$?
                if [ $CACHE_OUTPUT_RC -ne 0 ]; then
                    echo "Cannot get ssh configuration info, check if VM is running." && break
                fi
                LINE=$(echo -e "$CACHE_OUTPUT" | awk '/Host/{ print NR; exit }')
                echo -e "$CACHE_OUTPUT" | tail -n +$(($LINE)) > $CACHE_FILE
            fi

            if [ -f $CACHE_FILE ]; then
              ssh -F $CACHE_FILE default $@ || (echo "Cannot connect to VM by SSH. SSH connection file will be deleted." && rm $CACHE_FILE)
            fi

            break
        fi

        DIR=$(dirname $DIR);
    done
}
