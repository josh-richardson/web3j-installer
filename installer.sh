#!/bin/bash
local=~/
web3j_version="4.5.5"
clean_up() {
if [ -d "${local}.web3j" ]; then
echo "Looks like the .web3j folder exists in your local directory."
else 
echo "Creating web3j directory at path ${local}.web3j"
mkdir "${local}.web3j"
fi
}
set_path() {

  if (test -f "${HOME}/.bash_profile" && ! grep -s --quiet ".web3j/web3j-${web3j_version}" "$HOME/.bash_profile"); then
    echo "export PATH=\$PATH:~/.web3j/web3j-${web3j_version}/bin" >> ~/.bash_profile
    echo "Web3j has been added to your bash_profile path variable."
    
   else 
    echo "Web3j path exists in bash_profile"
   fi
  if (test -f "${HOME}/.bashrc" && ! grep -s --quiet ".web3j/web3j-${web3j_version}" "$HOME/.bashrc"); then
    echo "export PATH=\$PATH:~/.web3j/web3j-${web3j_version}/bin" >> ~/.bashrc
    echo "Web3j has been added to your bashrc path variable."   
   
  else 
     echo "Web3j path exists in bashrc"
  fi
  if (test -f "${HOME}/.zshrc" && ! grep -s --quiet ".web3j/web3j-${web3j_version}" "$HOME/.zshrc"); then
    echo "export PATH=\$PATH:~/.web3j/web3j-${web3j_version}/bin" >> ~/.zshrc
    echo "Web3j has been added to your zshrc path variable."
   
  else
     echo "Web3j path exists in zshrc"
  fi
  {
    echo "export PATH=\${PATH}:~\.web3j/web3j-${web3j_version}/bin"
  } > ~/.web3j/path-update.sh 
  chmod 777 ~/.web3j/path-update.sh 
}

add_to_path() {
  while read -p "Would you like to add Web3j to your local path ? [y]es | [n]o : " user_input ; do
   case $user_input in
    y)
      set_path
      break
      ;;
    n)
      echo "Web3j was not added to path. Path to binary: ~/web3j/web3j-${web3j_version}/bin/web3j"
      exit 0
      ;;
    esac
  done
}

completed() {
  echo -e "\e[42m Web3j was succesfully installed \e[0m"
  echo "To get started you will need Web3j's bin directory in your PATH enviroment variable."
  echo "When you open a new terminal window this will be done automatically." 
  echo "To see what web3j's CLI can do you can check the documentation bellow."
  echo -e "\e[92m https://docs.web3j.io/command_line_tools/ \e[0m "
  echo "To use web3j in your current shell run source \$HOME/.web3j/path-update.sh "
}

download_installer() {
if [[ $(curl --write-out %{http_code} --silent --output /dev/null "https://raw.githubusercontent.com/AlexandrouR/web3j-installer/master/web3j.sh") -eq 200 ]] ; then
    echo "Downloading install script ..."
    curl -# -L -o ~/.web3j/web3j.sh "https://raw.githubusercontent.com/AlexandrouR/web3j-installer/master/web3j.sh"
    chmod 777 ~/.web3j/web3j.sh  
    ~/.web3j/web3j.sh < /dev/tty
 else
  echo "Looks like there was an error while trying to get the web3j install script."
  exit 0
 fi

}
clean_up
download_installer
add_to_path 
completed
