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
pkg=wildfly
wfHome=/opt/wildfly
wfLog=/var/log/wildfly
# ./install/addPkgUser.sh $wfAdmin, wfGroup, $wfHome $wfLog $pkg

# create required wildfly directories
mkdir -p $wfHome
mkdir -p $wfLog 

#Check if wildfly user exists
if grep -q $wfAdmin "/etc/passwd"; then
   echo Wildfly User $wfAdmin exists; Not adding
else
   # create wildfly user $wfAdmin and wildfly group $wfGroup
   echo Adding wildflyuser $wfAdmin to group $wfGroup
   groupadd $wfGroup
   useradd -M -s /bin/bash -g $wfGroup -d /opt/wildfly $wfAdmin
   # add wildfly ssh access
   cp -r ~ec2-user/.ssh ~$wfAdmin
fi

# DOWNLOAD AND INSTALL WILDFLY 10
# ./install/installjBoss.sh

wfPkg=wildfly-10.0.0.Final.tar.gz

wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
echo EXECUTING tar -xzf $wfPkg -C /opt/wildfly --strip 1
tar -xzf $wfPkg -C /opt/wildfly --strip 1
echo y | rm $wfPkg 
cd  /opt/wildfly

#finally chown and groups to wildfly for home directory objects

chown -R wildfly:wildfly ~wildfly
chown -R wildfly:wildfly $wfLog
# install wildfly as service

# add wildfly Admin User
~wildfly/bin/add-user.sh admin admin --silent

#------------------- SET UP WILDFLY CONFIGURATION ---------------
# ./install/configurejBoss.sh
#Copy init scripts

echo y | cp /opt/wildfly/docs/contrib/scripts/init.d/wildfly-init-redhat.sh /etc/init.d/wildfly

echo y | rm -f /etc/default/wildfly.conf
cp /opt/wildfly/docs/contrib/scripts/init.d/wildfly.conf /etc/default
sed -i 's/# JAVA_HOME="\/usr\/lib\/jvm\/default-java"/JAVA_HOME=\/usr\/lib\/jvm\/java-1.8.0/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_HOME/JBOSS_HOME/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_USER/JBOSS_USER/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_CONFIG/JBOSS_CONFIG/g' /etc/default/wildfly.conf
sed -i 's/# STARTUP_WAIT/STARTUP_WAIT/g' /etc/default/wildfly.conf
sed -i 's/# SHUTDOWN_WAIT/SHUTDOWN_WAIT/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_CONSOLE_LOG/JBOSS_CONSOLE_LOG/g' /etc/default/wildfly.conf

#Set the local hostname
cp ~wildfly/standalone/configuration/standalone.xml ~wildfly/standalone/configuration/standalone.xml.BAK
sed -i "s/127.0.0.1/$(hostname -I)/g" ~wildfly/standalone/configuration/standalone.xml

#------------------- ADD WILDFLY AS A SERVICE AND START WILDFLY SERVICE ---------------

chkconfig --add wildfly
chkconfig wildfly on
service wildfly start

# start wildfly bind to all address
#sudo -u wildfly /opt/wildfly/bin/standalone.sh -b=0.0.0.0 &
# or if you want to also bind the management port to all address
#sudo -u wildfly /opt/wildfly/bin/standalone.sh -b=0.0.0.0 -bmanagement=0.0.0.0 &
cd $wfCurrDir
