#!/bin/bash

# check for system variables
if [ -z $HOME_FOLDER ]; then
    HOME_FOLDER=`$HOME`
fi
if [ -z $USER_NAME ]; then
    USER_NAME=`whoami`
fi

# install system dependencies
apt-get update
apt-get install -y build-essential git ruby ruby-dev libxml2 libxml2-dev \
    libxslt-dev libcurl4-openssl-dev libsqlite3-dev libyaml-dev zlib1g-dev \
    python-dev python-pip python-setuptools curl nmap w3af-console wget



# install gauntlt, from source
GAUNTLT_DIR=`pwd` # user current working directory
gem install bundler
bundle install
rake install
git submodule update --init --recursive --force
# git submodule update --init --recursive --force --remote --merge



# install sslyze
if ! type "sslyze" > /dev/null; then
    cd $GAUNTLT_DIR/vendor/sslyze
    pip install -r requirements.txt
    ln -s `pwd`/sslyze_cli.py /usr/bin/sslyze
fi



# install sqlmap
if ! type "sqlmap" > /dev/null; then
    cd $GAUNTLT_DIR/vendor/sqlmap
    ln -s `pwd`/sqlmap.py /usr/bin/sqlmap
fi



# install Go, Heartbleed
if ! type "Heartbleed" > /dev/null; then
    apt-get install -y golang
    export GOPATH=$HOME_FOLDER/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
    cat << 'EOF' >> $HOME_FOLDER/.bashrc

# configure go pathways
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
EOF
    go get github.com/FiloSottile/Heartbleed
fi


# install dirb
if ! type "dirb" > /dev/null; then
    cd $GAUNTLT_DIR/vendor
    wget -q http://downloads.sourceforge.net/project/dirb/dirb/2.22/dirb222.tar.gz
    tar -zxf dirb222.tar.gz
    mv dirb222 dirb
    chmod -R +x ./dirb
    cd dirb
    chown -R $(whoami) .
    bash ./configure
    make
    ln -s `pwd`/dirb /usr/bin/dirb
fi


# install Garmr, from source
if ! type "garmr" > /dev/null; then
    cd $GAUNTLT_DIR/vendor/Garmr
    python setup.py install
fi


# install Arachni, from a gem
if ! type "arachni" > /dev/null; then
    gem install arachni -v 1.0.6
    gem install service_manager
fi


# start gruyere
cd $GAUNTLT_DIR/vendor/gruyere
bash ./manual_launch.sh

# set the environmental variables
cd $GAUNTLT_DIR/vendor/dirb/wordlists
export DIRB_WORDLISTS=`pwd`
export SSLYZE_PATH=`which sslyze`
export SQLMAP_PATH=`which sqlmap`

# save environmental variables to .bashrc
cat << EOF >> $HOME_FOLDER/.bashrc

# configure environmental variables for Gauntlt
export DIRB_WORDLISTS=`pwd`
export SSLYZE_PATH=`which sslyze`
export SQLMAP_PATH=`which sqlmap`
EOF

# chown the environment
cd $GAUNTLT_DIR
chown -R $USER_NAME ./
