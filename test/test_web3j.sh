#!/bin/bash
set -e
JAVA_EXECUTABLE=$(readlink -f $(which java))
export JAVA_HOME=$(dirname $(dirname $JAVA_EXECUTABLE))
echo $JAVA_HOME
bash installer.sh
echo "Web3j source script content:"
cat $HOME/.web3j/source.sh
echo "Sourcing web3j source script"
source $HOME/.web3j/source.sh
echo "Content of bashrc:"
cat ~/.bashrc
echo "System path:"
echo $PATH
web3j version
