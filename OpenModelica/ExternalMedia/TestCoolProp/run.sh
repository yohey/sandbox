#!/bin/sh

(
    if [ "$(uname -m)" == "arm64" ]
    then
        . /opt/homebrew/opt/modules/init/sh
        export MODULEPATH=/opt/homebrew/etc/modules
    else
        . /usr/local/opt/modules/init/sh
        export MODULEPATH=/usr/local/etc/modules
    fi

    module purge
    module load openmodelica/1.18.1

    omc script.mos
)
