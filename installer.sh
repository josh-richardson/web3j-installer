#!/bin/bash

local=~/

clean_up() {
if [ -d "${local}.web3j" ]; then
echo "Looks like the .web3j folder exists in your local directory."
else 
echo "Creating web3j directory at path ${local}.web3j"
mkdir "${local}.web3j"
fi
}

download_installer() {
if [[ $(curl --write-out %{http_code} --silent --output /dev/null "https://raw.githubusercontent.com/web3j/web3j-installer/master/web3j.sh") -eq 200 ]] ; then
    echo "Downloading install script ..."
    curl -# -L -o ~/.web3j/web3j.sh "https://raw.githubusercontent.com/web3j/web3j-installer/master/web3j.sh"
    chmod 777 ~/.web3j/web3j.sh 
 else
  echo "Looks like there was an error while trying to get the web3j install script."
  exit 0
 fi

}
clean_up
download_installer
