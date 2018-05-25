#ToDo Configure JBOSS
wfHome=$1

# Backup original standalone.xml and configure the local hostname for remoting
cp $wfHome/standalone/configuration/standalone.xml $wfHome/standalone/configuration/standalone.xml.BAK
sed -i "s/127.0.0.1/$(hostname -I)/g" $wfHome/standalone/configuration/standalone.xml
