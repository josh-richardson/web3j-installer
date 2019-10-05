#!/bin/bash
set -e
JAVA_EXECUTABLE=$(readlink -f $(which java))
export JAVA_HOME=$(dirname $(dirname $JAVA_EXECUTABLE))
echo $JAVA_HOME
bash installer.sh
ls
source ~/.bashrc
web3j version
