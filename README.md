# gauntlt [![Build Status](https://secure.travis-ci.org/gauntlt/gauntlt.png?branch=master)](http://travis-ci.org/gauntlt/gauntlt) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/gauntlt/gauntlt)

gauntlt is a ruggedization framework

## PROJECT STATUS

The gauntlt project is under active development and is not ready for production use but we are looking for community feedback and involvement on the project.  Please file issues via github and follow the project on twitter: [@gauntlt](https://twitter.com/gauntlt).

Have questions?  Ask us anything on the [gauntlt google group](http://bit.ly/gauntlt_group) or find us on irc at [#gauntlt](http://webchat.freenode.net/?channels=gauntlt) (irc.freenode.net).

## GET STARTED

Note: if you are new to gauntlt, have a look at [gauntlt-starter-kit](https://github.com/gauntlt/gauntlt-starter-kit), which is the easiest way to get up and running with gauntlt.

You will need ruby version `1.9.3` to run gauntlt, but you can run gauntlt against applications built with any language or platform.

1. Install the gem

        $ gem install gauntlt

2. Create an attack file and put it anywhere you like

        # simplest.attack
        Feature: simplest attack possible
          Scenario:
            When I launch a "generic" attack with:
              """
              ls -a
              """
            Then the output should contain:
              """
              .
              """

3. Run gauntlt to launch the attack defined above

        $ gauntlt
        # equivalent to gauntlt ./**/*.attack
        # by default, gauntlt will search in the current folder
        # and its subfolders for files with the .attack extension
        #
        # you can also specify one or more paths yourself:
        $ gauntlt my_attacks/*.attack some_other.file


      For more attack examples, refer to the [examples](https://github.com/gauntlt/gauntlt/tree/master/examples).

4. Other commands

        # list defined attacks
        $ gauntlt --list

        # get help
        $ gauntlt --help


## ATTACK ADAPTERS

Gauntlt includes attack adapters for the following tools:

* [curl] [curl]
* [nmap] [nmap]
* [sslyze] [sslyze]
* [sqlmap] [sqlmap]
* [Garmr] [garmr]

You will need to install each tool yourself before you can use it with gauntlt. However, if you try to use a tool that is not installed or that gauntlt cannot find, you will get a helpful error message from gauntlt with information on how to install and/or configure the tool for use with gauntlt.

We also include a generic attack adapter that allows you to run anything on the command line, parse its output and check its exit status.


## ATTACK FILES

### Preamble

To use gauntlt, you will need one or more attack files. An attack file is a plain text file written with [Gherkin](https://github.com/cucumber/gherkin) syntax and named with the `.attack` extension. For more info on the Gherkin syntax, have a look at [Cucumber](http://cukes.info). A gauntlt attack file is almost the same as a cucumber feature file. The main difference is that gauntlt aims to provide the user with predefined steps geared towards security and durability testing so that you do not have to write your own step definitions, whereas cucumber is aimed at developers and stakeholders building features from end to end. Gauntlt and cucumber can and do work together harmoniously.

### What an attack file looks like

    # my.attack
    Feature: Description for all scenarios in this file
      Scenario: Description of this scenario
        Given ...
        When ...
        Then ...

      Scenario: ...
        Given ...
        When ...
        Then ...

You can have as many `Scenario` entries as you like, but it is good practice to keep the number low and to ensure that the scenarios in an attack file are all related. You can create as many attack files as you like and organize them in folders and sub-folders as well.

There are a large number of step definitions available, but you can do a lot with just these 3:

    Feature: Attack with kindness

      Scenario: Ensure I am not mean
        # verify a given attack adapter is installed
        # HIGHLY RECOMMENDED to catch installation/configuration problems
        Given "kindness" is installed

        # Execute the attack
        When I launch a "kindness" attack with:
          """
          whoami  # EXACT commands to be executed on the command line
          """

        # Check exit status and STDOUT
        Then it should pass with:
          """
          very_kind
          """


## FOR DEVELOPERS

NOTE: We currently use `ruby 1.9.3` and `JRuby 1.7.0` for development and testing.

1. Clone the git repo and get the submodules

        $ git clone --recursive git://github.com/gauntlt/gauntlt.git

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

        $ bin/gauntlt attack

5. Refer to the features directory for usage examples and please write cucumber features for any new functionality you wish to submit.


## ROADMAP

Gauntlt is under active development and we appreciate your suggestions and bug reports. We aim to be very responsive and friendly while adhering to a consistent design based on minimalism, simplicity and extensibility.

## LICENSE

gauntlt is licensed under The MIT License. See the LICENSE file in the repo or visit [gauntlt.mit-license.org](http://gauntlt.mit-license.org/) for details.

[curl]: http://curl.haxx.se
[nmap]: http://nmap.org
[sslyze]: https://github.com/iSECPartners/sslyze
[sqlmap]: http://sqlmap.org
[garmr]: https://github.com/mozilla/Garmr