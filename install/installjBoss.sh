wfPkg=wildfly-10.0.0.Final.tar.gz
wfPkg=$1
wfHome=$2

wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
echo EXECUTING tar -xzf $wfPkg -C $wfHome --strip 1
tar -xzf $wfPkg -C $wfHome --strip 1
echo y | rm $wfPkg 
cd  $wfHome

#finally chown and groups to wildfly for home directory objects

chown -R wildfly:wildfly ~wildfly

wfLog=/var/log/wildfly
mkdir -p $wfLog 
chown -R wildfly:wildfly $wfLog
# install wildfly as service
