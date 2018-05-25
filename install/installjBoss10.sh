# WILDFLY INITIAL INSTALLATION SETUP
wfHome=$1
wfPkg=wildfly-10.0.0.Final.tar.gz
wfLog=/var/log/wildfly

# DOWNLOAD WILDFLY
wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
echo EXECUTING tar -xzf $wfPkg -C $wfHome --strip 1

EXTRACT TO HOME DIRECTORY
tar -xzf $wfPkg -C $wfHome --strip 1
echo y | rm $wfPkg 

# CHANGE TO APPROPRIATE OWNER:GROUP
chown -R wildfly:wildfly $wfHome

mkdir -p $wfLog 
chown -R wildfly:wildfly $wfLog
