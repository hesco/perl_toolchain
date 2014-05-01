#!/bin/bash
set -e 

export HOME=/opt/local/pinto
cd $HOME

PINTO_PASSWORD=secret
PINTO_HOST=puppet.yourmessagedelivered.com
PINTO_PORT=3111

if [[ ! `grep PINTO_REPOSITORY_ROOT /root/.bashrc | wc -l` > 0 ]] ; then 
    /bin/echo "export PINTO_HOME=/opt/local/pinto" >> /root/.bashrc ;
    /bin/echo "export PINTO_CREDS='-u deploy -p $PINTO_PASSWORD '" >> /root/.bashrc ;
    /bin/echo "export PINTO_URL_CREDS=deploy:$PINTO_PASSWORD" >> /root/.bashrc ;
    /bin/echo "export PINTO_REPOSITORY_ROOT=http://$PINTO_URL_CREDS@$PINTO_HOST:$PINTO_PORT" >> /root/.bashrc ;
fi

source /root/.bashrc
/usr/bin/curl -L http://getpinto.stratopan.com | bash

if [[ ! `grep '/opt/local/pinto/etc/bashrc' /root/.bashrc | wc -l` > 0 ]] ; then 
    /bin/echo "source $HOME/etc/bashrc" >> /root/.bashrc ; 
fi

/bin/chmod u+x /root/.bashrc
source /root/.bashrc

if [[ -f $PINTO_HOME/.bashrc && ! `grep PINTO_REPOSITORY_ROOT $HOME/.bashrc | wc -l` > 0 ]] ; then 
    /bin/echo "export PINTO_HOME=/opt/local/pinto" >> $HOME/.bashrc ;
    /bin/echo "export PINTO_CREDS='-u deploy -p $PINTO_PASSWORD '" >> $HOME/.bashrc ;
    /bin/echo "export PINTO_URL_CREDS=deploy:$PINTO_PASSWORD" >> $HOME/.bashrc ;
    /bin/echo "export PINTO_REPOSITORY_ROOT=http://$PINTO_URL_CREDS@$PINTO_HOST:$PINTO_PORT" >> $HOME/.bashrc ;
    /bin/echo "source $PINTO_HOME/etc/bashrc" >> $HOME/.bashrc ; 
fi

source /root/.bashrc
/opt/local/pinto/bin/pinto --version > /opt/local/pinto/version

echo 0

