#!/bin/bash -x

script=~/znode.js

wget -q https://raw.githubusercontent.com/kevzoid/znode-REPL/master/znode.js \
    -O $script

if [[ $? -ne 0 ]]; then
    echo "Script download failed" >&2
    exit 1
fi

chmod a+x $script

# check if /.local/bin is even in $PATH
if ! [[ -L ~/.local/bin/znode ]]; then
    echo "Symlinking $script -> $HOME/.local/bin/znode"
    ln -s $script ~/.local/bin/znode
fi

if ! grep -q "alias znode=" ~/.bashrc; then
    echo 'alias znode="sb 1 &>/dev/null && znode"' >> ~/.bashrc
fi

echo 'DONE: open a new shell and type `znode` to enter the REPL'