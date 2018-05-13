#!/bin/bash
currDir=$(PWD)

#------------------- INITIAL BASIC TOOLS INSTALL --------------------
yum update -y

#------------------- INSTALL GITHUB --------------------
yum install git -y

#------------------- INSTALL MASTER BOOTSTRAP APPLICATIONS --------------------
bootStrapsDir=/var/scripts/bootstraps
git clone https://github.com/RMelanson/linux-scripts-bootstraps.git $bootStrapsDir
echo bootstraps installed in directory $bootStrapDir
cd $bootStrapsDir

#------------------- INSTALL DEV TOOLS --------------------
./devToolsBootstrap.sh
cd $currDir
