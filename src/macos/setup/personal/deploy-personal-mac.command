#!/bin/bash

##################################
## DEPLOY PERSONAL MAC - JUSTIN ##
##################################

{ # Wrap script in error logging

# Gather necessary input
echo -n "Admin Password: "
read -rs PASSWORD

# Install Command Line Tools
xcode-select --install

# Install Homebrew
echo "$PASSWORD" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Git
brew install git
mkdir "$HOME"/git
mkdir "$HOME"/git/personal

# Install Languages
brew cask install adoptopenjdk # must come before maven, will require an admin password to install
brew cask install dotnet-sdk
brew install maven
brew install node
brew install php
brew install python
brew install rust
brew install yarn

# Install Composer for PHP package management
curl -sS https://getcomposer.org/installer | php
echo "$PASSWORD" | sudo -S mv composer.phar composer
echo "$PASSWORD" | sudo -S mv composer /usr/local/bin/
echo "$PASSWORD" | sudo -S chmod 755 /usr/local/bin/composer

# Install Laravel Globally
composer global require laravel/installer

# Install apps
brew cask install 1password
brew cask install aerial
brew cask install anytrans
brew cask install battle-net
brew cask install ccleaner
brew cask install discord
brew cask install docker
brew cask install firefox
brew cask install gimp
brew cask install google-chrome
brew cask install handbrake
brew cask install ibackup-viewer
brew cask install microsoft-excel
brew cask install microsoft-powerpoint
brew cask install microsoft-word
brew cask install minecraft
brew cask install mysqlworkbench
brew cask install nextcloud
brew cask install origin
brew cask install postman
brew cask install rocket-chat
brew cask install slack
brew cask install steam
brew cask install teamviewer
brew cask install tor-browser
brew cask install tunnelblick
brew cask install visual-studio-code
brew cask install zoomus

# Install dotfiles
bash <(curl -s https://raw.githubusercontent.com/justintime50/dotfiles/master/src/scripts/install.sh)

# Check for updates and restart
echo "$PASSWORD" | sudo -S softwareupdate -i -a
} 2> ~/deploy_script.log # End error logging wrapper
open ~/deploy_script.log # Open the log and have the user check for errors before finishing
echo -e "Script complete.\nPlease check error log (automatically opened) before restarting.\n\nPress <enter> to restart."
read -rn 1
echo "Shutting down..."
sleep 5
history -c
echo "$PASSWORD" | sudo -S shutdown -h now
