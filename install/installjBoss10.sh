# WILDFLY INITIAL INSTALLATION SETUP
wfHome=$1
wfOwner$2
wfGroup=$3
wfLog=$4
wfPkg=wildfly-10.0.0.Final.tar.gz

# DOWNLOAD WILDFLY
wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
echo EXECUTING tar -xzf $wfPkg -C $wfHome --strip 1

EXTRACT TO HOME DIRECTORY
tar -xzf $wfPkg -C $wfHome --strip 1
echo y | rm $wfPkg 

# CHANGE TO APPROPRIATE OWNER:GROUP
chown -R $wfOwner:$wfGroup $wfHome

mkdir -p $wfLog 
chown -R $wfOwner:$wfGroup $wfLog
