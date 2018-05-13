#!/bin/bash
currDir=$PWD
devToolsDir=/tmp/scripts/devtools
git clone https://github.com/RMelanson/linux-scripts-devtools.git $devToolsDir
cd $devToolsDir
chmod 744 setup.sh
./setup.sh
cd $currDir
