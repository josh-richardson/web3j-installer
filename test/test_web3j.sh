#!/bin/bash
set -e
if [ -f "C:\\windows\\system32\\drivers\\etc\\hosts" ]; then
#  choco install jdk8
  powershell -executionpolicy bypass .\\installer.ps1
  ~/.web3j/bin/web3j.bat version
  exit 0
fi

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
