#!/bin/bash

# XXX: rename to znode.js
rm ~/znodee.js

if [[ -e ~/znodee.js ]]; then
    echo "znode.js script already exists in the home dir" >&2
    exit 1
fi

wget https://raw.githubusercontent.com/kevzoid/znode-REPL/master/znodee.js -O \
    ~/znodee.js

if [[ $? -ne 0 ]]; then
    echo "Script download failed" >&2
    exit 1
fi

echo DONE