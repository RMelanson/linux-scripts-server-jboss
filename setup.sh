#! /bin/bash
wfCurrDir=$PWD
# Setup the required environment
. ./env/setEnv.sh

# SETUP WILDFLY CONFIGURATION PARAMETERS
wfAdmin=admin
wfOwner=wildfly;
wfGroup=wildfly
wfHome=/opt/wildfly
pkg=wildfly

#CHECK IF WILDFLY INSTALLED AND RETURN IF INSTALLED
. ./install/exitIfInstalled.sh

# DOWNLOAD AND INSTALL JAVA 8 AND MAKE DEFAULT
./install/installJava8.sh

# SET UP WILDFLY ADMIN USER
./install/addPkgUser.sh $wfOwner, wfGroup, $wfHome $pkg

# DOWNLOAD AND INSTALL WILDFLY 10
./install/installjBoss10.sh $wfHome

# SET UP WILDFLY REMOTING CONFIGURATION 
./install/configjBossRemoting.sh $wfHome $wfAdmin

# CONFIGURE WILDFLY AS A SERVICE AND START WILDFLY SERVICE ---------------
addjBossAsService.sh $wfHome 

# START JBOSS WILDFLY
service wildfly start

cd $wfCurrDir
