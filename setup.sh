#! /bin/bash
# INSTALL JBOSS ON LINUX WITH REMOTE ACCESS AS A SERVICE

# SETUP WILDFLY CONFIGURATION ENVIRONMENT AND PARAMETERS
. ./env/setEnv.sh

#CHECK IF WILDFLY INSTALLED AND RETURN IF INSTALLED
. ./utils/exitIfInstalled.sh $wfHome

# INSTALL REQUIRED DEVELOPMENT LIBRARIES
./installs/installJava8.sh

# SET UP WILDFLY ADMIN USER
./installs/addPkgUser.sh $wfOwner $wfGroup $wfHome $pkg

# DOWNLOAD AND INSTALL WILDFLY 10
./installs/installjBoss10.sh $wfOwner $wfGroup $wfHome $wfLog

# SET UP WILDFLY REMOTING CONFIGURATION 
./installs/configjBossRemoting.sh $wfHome $wfAdmin

# CONFIGURE WILDFLY AS A SERVICE AND START WILDFLY SERVICE
./installs/addjBossAsService.sh $wfHome 

# START JBOSS WILDFLY
service wildfly start
