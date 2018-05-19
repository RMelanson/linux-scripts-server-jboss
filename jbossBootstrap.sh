#!/bin/bash
jbossBootCurrDir=$PWD

#Set Cloning Properties
pkg=JBOSS
gitRepo="linux-scripts-apps-jboss.git $jbossDir"
installDir="/tmp/scripts/apps/JBOSS"
if [ "$1" = "ssh" ]; then
   clone="git clone git@github.com:RMelanson/"
else
   clone="git clone https://github.com/RMelanson/"
fi

# Clone $pkg
echo Executing $clone$gitRepo $installDir
$clone$gitRepo $installDir

# Setup $pkg
cd $installDir
. ./setup.sh

cd $jbossBootCurrDir
