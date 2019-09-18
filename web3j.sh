#!/bin/bash
web3j_version="4.5.0"
installed_flag=0
update_flag=0
local=~/

check_if_installed() {
  if [ -x "$(command -v web3j)" ] &>/dev/null; then
    echo 'Web3j is installed on you system.'
    installed_flag=1
  fi
}

set_path() {
  if (test -f "${HOME}/.bash_profile" && ! grep -s --quiet ".web3j/web3j-${web3j_version}" "$HOME/.bash_profile"); then
    echo "export PATH=\$PATH:~/.web3j/web3j-${web3j_version}/bin" >> ~/.bash_profile
    echo "Web3j has been added to your bash_profile path variable. Please re-open your shell to use Web3j."
  fi
  if (test -f "${HOME}/.bashrc" && ! grep -s --quiet ".web3j/web3j-${web3j_version}" "$HOME/.bashrc"); then
    echo "export PATH=\$PATH:~/.web3j/web3j-${web3j_version}/bin" >> ~/.bashrc
    echo "Web3j has been added to your bashrc path variable. Please re-open your shell to use Web3j."
  fi
  if (test -f "${HOME}/.zshrc" && ! grep -s --quiet ".web3j/web3j-${web3j_version}" "$HOME/.zshrc"); then
    echo "export PATH=\$PATH:~/.web3j/web3j-${web3j_version}/bin" >> ~/.zshrc
    echo "Web3j has been added to your zshrc path variable. Please re-open your shell to use Web3j."
  fi
}

download_web3j() {
  echo "Downloading Web3j ..."
  mkdir "${local}.web3j"
  wget -P "${local}.web3j" "https://github.com/web3j/web3j/releases/download/v${web3j_version}/web3j-${web3j_version}.zip" -q
  unzip -o "${local}.web3j/web3j-${web3j_version}.zip" -d "${local}.web3j"
  rm "${local}.web3j/web3j-${web3j_version}.zip"
}

check_version() {
  if ! (web3j version | grep $web3j_version) &>/dev/null; then
    echo "Your Web3j version is not up to date."
    get_user_input
  else
    echo "You already have the latest version of Web3j. Exiting."
    exit 0
  fi
}

get_user_input() {
  while :; do
    echo
    read -p "Would you like to update Web3j ? [y]es | [n]o : " user_input
    case $user_input in
    y)
      echo "Updating Web3j ..."
      update_flag=1
      break
      ;;
    n)
      echo "Aborting instalation ..."
      exit 0
      ;;
    esac
  done
}

check_if_web3j_homebrew() {
  if (command -v brew && ! (brew info web3j | grep "Not installed") &>/dev/null); then
    echo "Looks like Web3j is installed with Homebrew. Please use Homebrew to update. Exiting."
    exit 0
  fi
}

clean_up() {
  rm -r "${local}.web3j" &>/dev/null
  echo "Cleaning up old stuff ..."
}

main() {
  check_if_installed
  if [ $installed_flag -eq 1 ]; then
    check_if_web3j_homebrew
    check_version
    clean_up
    download_web3j
    set_path
  else
    clean_up
    download_web3j
    set_path
  fi
}
main
