#!/bin/bash
# This little script tries to mimic the .travis.yml setup so that when we are 
# doing local dev, we can run tests and make sure we are passing CI.

NMAP=`which nmap`
GARMR=`which garmr`
DIRB=`which dirb`
ARACHNI=`which arachni`

ERRORS=0

if [ -z $ARACHNI ]
  then
    MESSAGE="It looks like you dont have arachni-web-scanner installed.  You should be able to do 'gem install arachni' to install it.  You might need to install libcurl first, on ubuntu you can run 'sudo apt-get install libcurl4-openssl-dev && gem install arachni' For more info on arachni, go to arachni-scanner.com"
    ERRORS=$ERRORS+1 
fi

if [ -z $SSLYZE_PATH ]
  then
    MESSAGE="SSLYZE_PATH environment variable unset, try setting it to ./vendor/sslyze/sslyze.py if you havent updated the submodules we use in gauntlt, run this first: git submodule update --init --recursive"
    ERRORS=$ERRORS+1 
fi

if [ -z $SQLMAP_PATH ]
  then
    MESSAGE="SQLMAP_PATH environment variable unset, try setting it to ./vendor/sslyze/sqlmap.py if you havent updated the submodules we use in gauntlt, run this first: git submodule update --init --recursive"
    ERRORS=$ERRORS+1 
fi

if [ -z $GARMR ] 
  then
    MESSAGE="garmr is not installed in your path, try installing it 'cd vendor/Garmr && sudo python setup.py install && cd ../..'"
    ERRORS=$ERRORS+1 
fi

if [ -z $DIRB_WORDLISTS ]
  then 
    MESSAGE="DIRB_WORDLISTS environment variable not set, please set it. Usually this is where you extracted dirb in a directory called 'wordlists'"
    ERRORS=$ERRORS+1 
fi

if [ -z $DIRB ]
  then 
    MESSAGE="dirb is not installed in your path, try installing it 'wget http://downloads.sourceforge.net/project/dirb/dirb/2.03/dirb203.tar.gz && tar xvfz dirb203.tar.gz && cd dirb && ./configure && make && cd ..'"
    ERRORS=$ERRORS+1 
fi

if [ -z $NMAP ] 
  then
    MESSAGE="nmap is not installed in your path, try installing it (brew install nmap OR apt-get install nmap) and adding it to your path"
    ERRORS=$ERRORS+1 
fi



if [ $ERRORS -gt 0 ]
  then
  echo $MESSAGE
  ERRORS=$ERRORS-1
  echo "$ERRORS more things to fix... keep running ./ready_to_rumble.sh until you ARE."
else
  echo "You ARE ready to rumble!"
fi
