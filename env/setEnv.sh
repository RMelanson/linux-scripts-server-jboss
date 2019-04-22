#!/bin/bash

# JBOSS WILDFLY CONFIGURATION PARAMETERS
bootstrap="jbossBootstrap.sh"
gitRepo="linux-scripts-apps-jboss.git $jbossDir"

#SET UP INSTALLATION DIRECTORY`
pkg=JBOSS
scriptType="utils"
parentDir="/tmp/scripts/$scriptType/"
installDir="$parentDir/$pkg"

wfAdmin=admin
wfOwner=wildfly
wfGroup=wildfly
wfHome=/opt/wildfly
wfLog=/var/log/wildfly
