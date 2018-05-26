#! /bin/bash
# INSTALL JBOSS ON LINUX WITH REMOTE ACCESS AS A SERVICE

# SETUP WILDFLY CONFIGURATION ENVIRONMENT AND PARAMETERS
. ./env/setEnv.sh

#CHECK IF WILDFLY INSTALLED AND RETURN IF INSTALLED
. ./utils/exitIfInstalled.sh $wfHome

# SET UP WILDFLY ADMIN USER
./install/addPkgUser.sh $wfOwner $wfGroup $wfHome $pkg

# DOWNLOAD AND INSTALL WILDFLY 10
./install/installjBoss10.sh $wfOwner $wfGroup $wfHome $wfLog

#########################################################################

#wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
#echo EXECUTING tar -xzf $wfPkg -C $wfHome --strip 1
#tar -xzf $wfPkg -C $wfHome --strip 1
#echo y | rm $wfPkg 

#finally chown and groups to wildfly for home directory objects

#mkdir -p $wfLog
#chown -R wildfly:wildfly $wfHome
#chown -R wildfly:wildfly $wfLog
# install wildfly as service

# add wildfly Admin User
#$wfHome/bin/add-user.sh admin admin --silent

##################################################################################
# SET UP WILDFLY REMOTING CONFIGURATION 
./install/configjBossRemoting.sh $wfHome $wfAdmin

# CONFIGURE WILDFLY AS A SERVICE AND START WILDFLY SERVICE
./install/addjBossAsService.sh $wfHome 

# START JBOSS WILDFLY
service wildfly start

