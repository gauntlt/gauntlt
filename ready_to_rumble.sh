#!/bin/bash
# This little script tries to mimic the .travis.yml setup so that when we are 
# doing local dev, we can run tests and make sure we are passing CI.

NMAP=`which nmap`
GARMR=`which garmr`
DIRB=`which dirb`

if [ -z $NMAP ] 
  then
    echo "nmap is not installed in your path, try installing it and adding it to your path"
    exit
fi

if [ -z $SSLYZE_PATH ]
  then
    echo "SSLYZE_PATH environment variable unset, try setting it to ./vendor/sslyze/sslyze.py if you havent updated the submodules we use in gauntlt, run this first: git submodule update --init --recursive"
    exit
fi

if [ -z $SQLMAP_PATH ]
  then
    echo "SQLMAP_PATH environment variable unset, try setting it to ./vendor/sslyze/sqlmap.py if you havent updated the submodules we use in gauntlt, run this first: git submodule update --init --recursive"
    exit
fi

if [ -z $GARMR ] 
  then
    echo "garmr is not installed in your path, try installing it 'cd vendor/Garmr && sudo python setup.py install && cd ../..'"
    exit
fi

if [ -z $DIRB ]
  then 
    echo "dirb is not installed in your path, try installing it 'wget http://downloads.sourceforge.net/project/dirb/dirb/2.03/dirb203.tar.gz && tar xvfz dirb203.tar.gz && cd dirb && ./configure && make && cd ..'"
    exit
fi

if [ -z $DIRB_WORDLISTS ]
  then 
    echo "DIRB_WORDLISTS environment variable not set, please set it. Usually this is where you extracted dirb in a directory called 'wordlists'"
    exit
fi

echo "You are ready to rumble!"
