JAVA_EXECUTABLE=$(readlink -f $(which java))
export JAVA_HOME=$(dirname $(dirname $JAVA_EXECUTABLE))
bash web3j.sh
source ~/.bashrc
web3j version
bash