#!/bin/bash
currDir=$PWD
jbossDir=/tmp/scripts/apps/JBOSS
git clone https://github.com/RMelanson/linux-scripts-apps-jboss.git $jbossDir
cd $devToolsDir
chmod 744 setup.sh
./setup.sh
cd $currDir
