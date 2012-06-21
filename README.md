[![Build Status](https://secure.travis-ci.org/thegauntlet/gauntlt.png?branch=master)](http://travis-ci.org/thegauntlet/gauntlt)

INSTALL
=======

Using Ruby 1.9.3-head

GET STARTED
===========

# Code snippet goes here


After pulling from git, run bundle which installs cucumber and aruba then run cucumber.  Later we will provide a gauntlet wrapper for it that will allow you to set priority and speed wherein you will be able to walk the gauntlet or run the gauntlet. 

# This will install all needed gems
~/gauntlt$ bundle

# This will let you run the tests (use nmap for test_name and google.com for hostname)
~/gauntlt$ bundle exec gauntlt verify --test <test_name> --host <hostname>




ROADMAP
=======


Feel free to start adding other tools as features.  Below are some tools we are targeting but don't let that stop you from adding your favorite hacking tool.

./features/nmap.feature #in progress by wickett
./features/w3af.feature #not started
./features/nc.feature #not started
./features/sqlmap.feature #not started

./profile/profile.xml #this is where you can add app specific information and later reference that in your feature


