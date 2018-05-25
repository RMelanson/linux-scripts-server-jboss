#! /bin/bash
wfCurrDir=$PWD
# Setup the required environment
. ./env/setEnv.sh

#CHECK IF WILDFLY INSTALLED AND RETURN IF INSTALLED
if [ -d $wfHome ]
then
    echo WildFly Already installed EXITING
    return
fi

# DOWNLOAD AND INSTALL JAVA 8 AND MAKE DEFAULT
./install/installJava8.sh

# SET UP WILDFLY ADMIN USER
wfAdmin=wildfly;
wfGroup=wildfly
wfHome=/opt/wildfly
pkg=wildfly
./install/addPkgUser.sh $wfAdmin, wfGroup, $wfHome $pkg

# DOWNLOAD AND INSTALL WILDFLY 10
wfPkg=wildfly-10.0.0.Final.tar.gz
./install/installjBoss.sh $wfPkg $wfHome

# SET UP WILDFLY REMOTING CONFIGURATION 
./install/configjBossRemoting.sh $wfHome

#Copy init scripts
# COPY AND CONFIGURE INIT SERVICE SCRIPTS

echo y | cp $wfHome/docs/contrib/scripts/init.d/wildfly-init-redhat.sh /etc/init.d/wildfly

echo y | rm -f /etc/default/wildfly.conf
cp /opt/wildfly/docs/contrib/scripts/init.d/wildfly.conf /etc/default
sed -i 's/# JAVA_HOME="\/usr\/lib\/jvm\/default-java"/JAVA_HOME=\/usr\/lib\/jvm\/java-1.8.0/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_HOME/JBOSS_HOME/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_USER/JBOSS_USER/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_CONFIG/JBOSS_CONFIG/g' /etc/default/wildfly.conf
sed -i 's/# STARTUP_WAIT/STARTUP_WAIT/g' /etc/default/wildfly.conf
sed -i 's/# SHUTDOWN_WAIT/SHUTDOWN_WAIT/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_CONSOLE_LOG/JBOSS_CONSOLE_LOG/g' /etc/default/wildfly.conf

# ADD WILDFLY AS A SERVICE AND START WILDFLY SERVICE ---------------

chkconfig --add wildfly
chkconfig wildfly on
service wildfly start

# start wildfly bind to all address
#sudo -u wildfly /opt/wildfly/bin/standalone.sh -b=0.0.0.0 &
# or if you want to also bind the management port to all address
#sudo -u wildfly /opt/wildfly/bin/standalone.sh -b=0.0.0.0 -bmanagement=0.0.0.0 &
cd $wfCurrDir
