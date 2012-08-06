# gauntlt [![Build Status](https://secure.travis-ci.org/thegauntlet/gauntlt.png?branch=master)](http://travis-ci.org/thegauntlet/gauntlt) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/thegauntlet/gauntlt)

gauntlt is a ruggedization framework

## PROJECT STATUS

The gauntlt project is under active development and is not ready for production use but we are looking for community feedback and involvement on the project.  Please file issues via github and follow the project on twitter: [@gauntlt](https://twitter.com/gauntlt).

Have questions?  Ask us anything on the [gauntlt google group](http://bit.ly/gauntlt_group).

## GET STARTED

Before you start, please note that gauntlt is tested regularly against ruby 1.9.3. We don't test againt older versions of ruby. Keep in mind that you run gauntlt separately from the application it targets, so it does not matter whether the targeted application uses ruby.

1. Install the gem

        $ gem install gauntlt

2. Create an attack file and put it anywhere you like

        # nmap.attack
        Feature: nmap attacks
          Background:
            Given "nmap" is installed
            And the target hostname is "google.com"

          Scenario: Verify server is available on standard web ports
            When I launch an "nmap" attack with:
              """
              nmap -p 80,443 <hostname>
              """
            Then the output should contain:
              """
              80/tcp  open  http
              443/tcp open  https
              """

3. Run gauntlt to launch the attack defined above

        $ gauntlt attack -n nmap -a nmap.attack
        # general format:
        #  $ gauntlt attack --name <attack_name> --attack-file <path>


      For more attack examples, refer to features/attacks.

4. Other commands

        # list defined attacks
        $ gauntlt attack --list

        # get help
        $ gauntlt help


## For developers

1. Clone the git repo and get the submodules

        $ git clone --recursive git://github.com/thegauntlet/gauntlt.git

2. Install bundler

        $ gem install bundler

3. Install dependencies

        $ bundle
        # if you get errors, you may need to install curl libs first
        # on ubuntu:
        #   $ sudo apt-get install libcurl4-openssl-dev


4. Run the cucumber features and rspec examples

        $ bundle exec rake

5. Launch attacks with bin/gauntlt

        $ bin/gauntlt attack -n nmap -a my_attack_file.attack

5. Refer to the features directory for usage examples and please write cucumber features for any new functionality you wish to submit.


## ROADMAP

We are adding different features into gauntlt rignt now.  Please submit issues via github and tag them as enhancements.  The core team meets weekly and will divide out the enhancement requests into our monthly releases.

Below are some tools we are targeting but don't let that stop you from adding your favorite hacking tool.

  * [curl] [curl]
  * [nmap] [nmap]
  * [sslyze] [sslyze]
  * [sqlmap] [sqlmap]
  * [w3af] [w3af]
  * [arachni] [arachni]

Have questions?  Ask us anything on the [gauntlt google group](http://bit.ly/gauntlt_group).

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
