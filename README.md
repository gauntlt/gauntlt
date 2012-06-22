[![Build Status](https://secure.travis-ci.org/thegauntlet/gauntlt.png?branch=master)](http://travis-ci.org/thegauntlet/gauntlt)

INSTALL
=======

Using Ruby 1.9.3-head

GET STARTED
===========

This will install all needed gems
~/gauntlt$ bundle

This will let you run the tests (use nmap for test_name and google.com for hostname)
~/gauntlt$ bundle exec gauntlt verify --test <test_name> --host <hostname>

Try this one:
~/gauntlt$ bundle exec gauntlt verify --test nmap --host yahoo.com

ROADMAP
=======

We are adding different features into gauntlt rignt now.  Please submit issues via github and tag them as enhancements.  The core team meets weekly and will divide out the enhancement requests into our monthly releases.

Below are some tools we are targeting but don't let that stop you from adding your favorite hacking tool.

nmap
curl
w3af
sqlmap
arachni




