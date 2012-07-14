# gauntlt [![Build Status](https://secure.travis-ci.org/thegauntlet/gauntlt.png?branch=master)](http://travis-ci.org/thegauntlet/gauntlt)

gauntlt is a framework for behaviour-driven security.

## PROJECT STATUS

The gauntlt project is under active development and is not ready for production use but we are looking for community feedback and involvement on the project.  Please file issues via github and follow the project on twitter: @gauntlt.


## GET STARTED

Before you start, please note that gauntlt is tested regularly against ruby 1.9.3 and 1.9.2 . We don't test againt ruby 1.8.7. Keep in mind that you run gauntlt separately, so its version of ruby should not be a big deal.

1. Clone the git repo

        $ git clone git@github.com:thegauntlet/gauntlt.git
        $ cd gauntlt


2. Install bundler
        
        $ gem install bundler


3. Install dependencies

        $ bundle


4. Run a specific gauntlt test
        
        # general format
        $ bin/gauntlt --test <test_name> --host <hostname>
         
        # for example, run the nmap test on yahoo
        $ bin/gauntlt verify --test nmap --host yahoo.com
 
        # list defined tests
        $ bin/gauntlt verify --list

        # get help
        $ bin/gauntlt --help
        $ bin/gauntlt verify --help


## ROADMAP

We are adding different features into gauntlt rignt now.  Please submit issues via github and tag them as enhancements.  The core team meets weekly and will divide out the enhancement requests into our monthly releases.

Below are some tools we are targeting but don't let that stop you from adding your favorite hacking tool.

nmap
curl
w3af
sqlmap
arachni


## LICENSE

gauntlt is licensed under The MIT License. See the LICENSE file in the repo or visit [gauntlt.mit-license.org](http://gauntlt.mit-license.org/) for details.