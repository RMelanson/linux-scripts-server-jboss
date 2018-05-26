#! /bin/bash
# INSTALL JBOSS ON LINUX WITH REMOTE ACCESS AS A SERVICE

# SETUP WILDFLY CONFIGURATION ENVIRONMENT AND PARAMETERS
. ./env/setEnv.sh

#CHECK IF WILDFLY INSTALLED AND RETURN IF INSTALLED
. ./utils/exitIfInstalled.sh $wfHome

# SET UP WILDFLY ADMIN USER
./install/addPkgUser.sh $wfOwner $wfGroup $wfHome $pkg

# DOWNLOAD AND INSTALL WILDFLY 10
#./install/installjBoss10.sh $wfOwner $wfGroup $wfHome $wfLog

# SET UP WILDFLY REMOTING CONFIGURATION 
#./install/configjBossRemoting.sh $wfHome $wfAdmin

#########################################################################

# DOWNLOAD AND INSTALL WILDFLY 10
# ./install/installjBoss.sh

wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
echo EXECUTING tar -xzf $wfPkg -C $wfHome --strip 1
tar -xzf $wfPkg -C $wfHome --strip 1
echo y | rm $wfPkg 
cd  $wfHome

#finally chown and groups to wildfly for home directory objects

mkdir -p $wfLog
chown -R wildfly:wildfly $wfHome
chown -R wildfly:wildfly $wfLog
# install wildfly as service

# add wildfly Admin User
$wfHome/bin/add-user.sh admin admin --silent

#------------------- SET UP WILDFLY CONFIGURATION ---------------
# ./install/configurejBoss.sh
#Copy init scripts

#echo y | cp $wfHome/docs/contrib/scripts/init.d/wildfly-init-redhat.sh /etc/init.d/wildfly

#echo y | rm -f /etc/default/wildfly.conf
#cp $wfHome/docs/contrib/scripts/init.d/wildfly.conf /etc/default
#sed -i 's/# JAVA_HOME="\/usr\/lib\/jvm\/default-java"/JAVA_HOME=\/usr\/lib\/jvm\/java-1.8.0/g' /etc/default/wildfly.conf
#sed -i 's/# JBOSS_HOME/JBOSS_HOME/g' /etc/default/wildfly.conf
#sed -i 's/# JBOSS_USER/JBOSS_USER/g' /etc/default/wildfly.conf
#sed -i 's/# JBOSS_CONFIG/JBOSS_CONFIG/g' /etc/default/wildfly.conf
#sed -i 's/# STARTUP_WAIT/STARTUP_WAIT/g' /etc/default/wildfly.conf
#sed -i 's/# SHUTDOWN_WAIT/SHUTDOWN_WAIT/g' /etc/default/wildfly.conf
#sed -i 's/# JBOSS_CONSOLE_LOG/JBOSS_CONSOLE_LOG/g' /etc/default/wildfly.conf

#Set the local hostname
#cp $wfHome/standalone/configuration/standalone.xml $wfHome/standalone/configuration/standalone.xml.BAK
#sed -i "s/127.0.0.1/$(hostname -I)/g" $wfHome/standalone/configuration/standalone.xml

#------------------- ADD WILDFLY AS A SERVICE AND START WILDFLY SERVICE ---------------

#chkconfig --add wildfly
#chkconfig wildfly on
#service wildfly start
##################################################################################
# CONFIGURE WILDFLY AS A SERVICE AND START WILDFLY SERVICE
./install/addjBossAsService.sh $wfHome 

# START JBOSS WILDFLY
service wildfly start

