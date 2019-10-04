#!/bin/bash
web3j_version="4.5.5"
installed_flag=0
update_flag=0
local=~/

check_if_installed() {
  if [ -x "$(command -v web3j)" ] &>/dev/null; then
    echo 'A web3j installation exists on your system.'
    installed_flag=1
  fi
}



download_web3j() {
  echo "Downloading Web3j ..."
  mkdir "${local}.web3j" &>/dev/null
 if [[ $(curl --write-out %{http_code} --silent --output /dev/null "https://github.com/web3j/web3j-cli/releases/download/v${web3j_version}/web3j-${web3j_version}.zip") -eq 302 ]] ; then
    curl -# -L -o ~/.web3j/web3j-${web3j_version}.zip "https://github.com/web3j/web3j-cli/releases/download/v${web3j_version}/web3j-${web3j_version}.zip" 
    unzip  -o "${local}.web3j/web3j-${web3j_version}.zip" -d "${local}.web3j"
    echo "Removing zip file ..."
    rm "${local}.web3j/web3j-${web3j_version}.zip"
 else
  echo "Looks like there was an error while trying to download web3j"
  exit 3
 fi
}

check_version() {
  version_string=`web3j version | grep Version | awk -F" "  '{print $NF}'`
  echo $version_string
  if [[ $version_string < $web3j_version ]] ; then
    echo "Your Web3j version is not up to date."
    get_user_input
  else
    echo "You have the latest version of Web3j. Exiting."
    exit 3
  fi
}

get_user_input() {

  while read -p "Would you like to update Web3j ? [y]es | [n]o : " user_input < /dev/tty; do
    case $user_input in
    y)
      echo "Updating Web3j ..."
      update_flag=1
      break
      ;;
    n)
      echo "Aborting instalation ..."
      exit 3
      ;;
    esac
  done
}



check_if_web3j_homebrew() {
  if (command -v brew && ! (brew info web3j | grep "Not installed") &>/dev/null); then
    echo "Looks like Web3j is installed with Homebrew. Please use Homebrew to update. Exiting."
    exit 3
  fi
}

clean_up() {
  if [ -d "${local}.web3j" ] ; then
  rm -r "${local}.web3j" &>/dev/null
  echo "Deleting older installation ..."
  fi
}

main() {
  check_if_installed
  if [ $installed_flag -eq 1 ]; then
    check_if_web3j_homebrew
    check_version
    clean_up
    download_web3j
    
  else
    download_web3j
    
  fi
}

main