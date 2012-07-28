# gauntlt [![Build Status](https://secure.travis-ci.org/thegauntlet/gauntlt.png?branch=master)](http://travis-ci.org/thegauntlet/gauntlt)

gauntlt is a framework for behaviour-driven security.

## PROJECT STATUS

The gauntlt project is under active development and is not ready for production use but we are looking for community feedback and involvement on the project.  Please file issues via github and follow the project on twitter: [@gauntlt](https://twitter.com/gauntlt).


## GET STARTED

Before you start, please note that gauntlt is tested regularly against ruby 1.9.3. We don't test againt older versions of ruby. Keep in mind that you run gauntlt separately from the application it targets, so it does not matter whether the targeted application uses ruby.

1. Clone the git repo

        $ git clone git@github.com:thegauntlet/gauntlt.git
        $ cd gauntlt


2. Install bundler
        
        $ gem install bundler


3. Install dependencies

Note, you may see errors in bundle related to the curb gem.  It is looking for curl dependencies. In ubuntu you can do a sudo apt-get install libcurl4-openssl-dev 

        $ bundle

4. Run a specific gauntlt attack
        
        # general format
        $ bin/gauntlt attack --name <attack_name> --host <hostname>
         
        # for example, run the nmap test on yahoo (-n & -H are equivalent to --name & --host)
        $ bin/gauntlt attack -n nmap -H yahoo.com
 
        # list defined tests
        $ bin/gauntlt attack --list

        # get help
        $ bin/gauntlt help


## ROADMAP

We are adding different features into gauntlt rignt now.  Please submit issues via github and tag them as enhancements.  The core team meets weekly and will divide out the enhancement requests into our monthly releases.

Below are some tools we are targeting but don't let that stop you from adding your favorite hacking tool.

  * [curl] [curl]
  * [nmap] [nmap]
  * [sslyze] [sslyze]
  * [w3af] [w3af]
  * [sqlmap] [sqlmap]
  * [arachni] [arachni]


## ADD A MODULE
See the wiki on how to add a module into gauntlt. We would love your contributions.

## LICENSE

gauntlt is licensed under The MIT License. See the LICENSE file in the repo or visit [gauntlt.mit-license.org](http://gauntlt.mit-license.org/) for details.

[curl]: http://curl.haxx.se
[nmap]: http://nmap.org
[sslyze]: https://github.com/iSECPartners/sslyze
[w3af]: http://w3af.sourceforge.net
[sqlmap]: http://sqlmap.org
[arachni]: http://arachni-scanner.com