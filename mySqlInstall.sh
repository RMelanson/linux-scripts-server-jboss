#!/bin/bash
currDir=$PWD
mySqlDir=/tmp/scripts/apps/db/MYSQL
git clone https://github.com/RMelanson/linux-scripts-apps-db-mysql.git $mySqlDir
cd $mySqlDir
chmod 744 setup.sh
./setup.sh
cd $currDir
