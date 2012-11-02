#!/usr/bin/env sh

echo "Installing required gems."
echo
echo `bundle`
echo

echo "Checking for required packages.."

OS_VERSION=`sw_vers -productVersion`
# Install uservoice gem
if [[ $OS_VERSION == *10.8* ]]; then
  if which terminal-notifier >/dev/null; then
    echo "terminal-notifier: YES"
  else
    echo "terminal-notifier: NO"
    echo `gem install terminal-notifier`
  fi
else
  if which growlnotify >/dev/null; then
    echo "growlnotify: YES"
  else
    echo "growlnotify: NO"
    read -p "Visit Growl website for growlnotify? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        `open http://growl.info/extras.php#growlnotify`
        echo
        echo "Re-run install.sh when you're done installing."
        exit
    fi
  fi
fi
echo

INSTALL="/usr/local/bin/check_uservoice"

PATH=`pwd`"/check.rb"
echo "This installer will create a symbolic link from:"
echo $PATH
echo "to"
echo $INSTALL
echo

read -p "Are you sure? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo
  echo
  `/bin/ln -s "$PATH" "$INSTALL"`
  if [ $? -gt 0 ]; then
    echo "Failed: Check error and re-run install.sh."
  else
    echo "Done!"
    echo "Modify your sites.yml and run check_uservoice to check your tickets!"
  fi
fi
echo
