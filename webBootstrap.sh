#!/bin/bash
currDir=$PWD
devToolsDir=/tmp/scripts/apps/WEB
git clone https://github.com/RMelanson/linux-scripts-apps-web.git $devToolsDir
cd $devToolsDir
chmod 744 setup.sh
./setup.sh
cd $currDir
