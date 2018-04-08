[![Build Status](https://secure.travis-ci.org/gauntlt/gauntlt.png?branch=master)](http://travis-ci.org/gauntlt/gauntlt)
[![Code Climate](https://codeclimate.com/github/gauntlt/gauntlt.png)](https://codeclimate.com/github/gauntlt/gauntlt)
[![Gem Version](https://badge.fury.io/rb/gauntlt.png)](http://badge.fury.io/rb/gauntlt)

# gauntlt
Gauntlt is a ruggedization framework that enables security testing that is
usable by devs, ops and security.

## PROJECT STATUS

As of 2018, Gauntlt is re-launching development efforts and building a commmunity
of practice. Join us on the [gauntlt slack channel](http://bit.ly/2EU9yGh). We are
hoping to extend gauntlt functionality, add attack adapters and buildup a library
of sharable attacks that fit everyone's needs. This isn't just for ruby developers,
we need feedback and contributions from security experts and people with experience
running gauntlt in build pipelines. Join us!

We welcome feedback and contributions.  Please file issues via
github and follow the project on twitter: [@gauntlt](https://twitter.com/gauntlt).

Have questions?  Feel free to open a ticket, but we would prefer you find us
on the [gauntlt slack channel](http://bit.ly/2EU9yGh) (gauntlt.slack.com).

## GET STARTED

You might want also take a look at [gauntlt-docker](https://github.com/gauntlt/gauntlt-docker)
which has gauntlt and a few attack tools all grouped into one container.

Note: if you are new to gauntlt, have a look at
[gauntlt-starter-kit](https://github.com/gauntlt/gauntlt-starter-kit), it is
the easiest way to get up and running.

If you are using Kali Linux 2.0, Debian Jessie, Ubuntu 14.04, or Ubuntu 15.10,
you can run the following:
```shell
git clone https://github.com/gauntlt/gauntlt
cd gauntlt
source ./install_gauntlt_deps.sh
bash ./ready_to_rumble.sh
gauntlt
```
This script will install Ruby RVM, all the required system dependencies and
tools, and update your .bashrc with the necessary environmental variables. You
 can install this for another user by exporting $HOME_FOLDER and $USER_NAME
variables before running install_gauntlt_deps.sh

To install Gauntlt from source, you will need ruby version `2.1.0` or higher,
but you can run gauntlt against applications built with any language or platform.

1. Install the gem

    ```shell
    $ gem install gauntlt
    ```

2. Create an attack file and put it anywhere you like. (There is a more relevant
example on gauntlt.org)

    ```gherkin
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
    ```

3. Run gauntlt to launch the attack defined above

    ```shell
    $ gauntlt
    # equivalent to gauntlt ./**/*.attack
    # by default, gauntlt will search in the current folder
    # and its subfolders for files with the .attack extension

    # you can also specify one or more paths yourself:
    $ gauntlt my_attacks/*.attack some_other.file
    ```

  For more attacks, refer to the [examples](https://github.com/gauntlt/gauntlt/tree/master/examples).

4. Other commands

    ```shell
    # list defined attacks
    $ gauntlt --list

    # get help
    $ gauntlt --help
    ```

## ATTACK ADAPTERS

Gauntlt includes attack adapters for the following tools:

* [arachni] [arachni]
* [curl] [curl]
* [dirb] [dirb]
* [Garmr] [garmr]
* [heartbleed] [heartbleed]
* [nmap] [nmap]
* [sqlmap] [sqlmap]
* [sslyze] [sslyze]

You will need to install each tool yourself before you can use it with gauntlt.
However, if you try to use a tool that is not installed or that gauntlt cannot
find, you will get a helpful error message from gauntlt with information on how
to install and/or configure the tool for use with gauntlt.

We also include a generic attack adapter that allows you to run anything on the
command line, parse its output and check its exit status.


## ATTACK FILES

### Preamble

To use gauntlt, you will need one or more attack files. An attack file is a plain text file written with [Gherkin](https://github.com/cucumber/gherkin) syntax and named with the `.attack` extension. For more info on the Gherkin syntax, have a look at [Cucumber](http://cukes.info). A gauntlt attack file is almost the same as a cucumber feature file. The main difference is that gauntlt aims to provide the user with predefined steps geared towards security and durability testing so that you do not have to write your own step definitions, whereas cucumber is aimed at developers and stakeholders building features from end to end. Gauntlt and cucumber can and do work together harmoniously.

### What an attack file looks like

```gherkin
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
```

You can have as many `Scenario` entries as you like, but it is good practice to keep the number low and to ensure that the scenarios in an attack file are all related. You can create as many attack files as you like and organize them in folders and sub-folders as well.

There are a large number of step definitions available, but you can do a lot with just these 3:

```gherkin
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
```

## FOR DEVELOPERS

NOTE: We currently use `ruby 2.3.4` for development and testing.

1. Clone the git repo and get the submodules

    ```shell
    $ git clone --recursive git://github.com/gauntlt/gauntlt.git
    ```

2. Install bundler

    ```shell
    cd gauntlt
    $ gem install bundler
    ```

3. Install dependencies

    ```shell
    $ bundle
    # if you get errors, you may need to install curl libs first
    # on ubuntu:
    #   $ sudo apt-get install libcurl4-openssl-dev
    # alternatively: update and use the install_gauntlt.sh script, tested on
    # Kali Linux 2.0, Debian Jessie, Ubuntu 14.04, and Ubuntu 15.10
    ```
4. Run the ready_to_rumble.sh script to make sure you have all the dependencies installed like sqlmap and sslyze.  This is meant to replicate the travis setup for devs. This should be a rake task instead.

5. Run the cucumber features and rspec examples

    ```shell
    $ bundle exec rake
    ```

6. Launch attacks with bin/gauntlt

    ```shell
    $ bin/gauntlt attack
    ```

7. Refer to the features directory for usage examples and please write cucumber features for any new functionality you wish to submit.


## ROADMAP

Gauntlt has been steady for some time now, but we are working on some new features. Join us on slack for more info.

We appreciate your suggestions and bug reports. We aim to be very responsive and friendly while adhering to a consistent design based on minimalism, simplicity and extensibility.

## LICENSE

gauntlt is licensed under The MIT License. See the LICENSE file in the repo or visit [gauntlt.mit-license.org](http://gauntlt.mit-license.org/) for details.

[arachni]: http://www.arachni-scanner.com/
[curl]: http://curl.haxx.se
[dirb]: http://dirb.sourceforge.net/
[garmr]: https://github.com/mozilla/Garmr
[heartbleed]: https://github.com/FiloSottile/Heartbleed
[nmap]: http://nmap.org
[sslyze]: https://github.com/iSECPartners/sslyze
[sqlmap]: http://sqlmap.org
