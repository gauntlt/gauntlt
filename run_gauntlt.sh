#!/bin/bash

# configure environmental variables
export DIRB_WORDLISTS=`locate dirb | grep "/dirb/wordlists$"`
export SSLYZE_PATH=`which sslyze`
export SQLMAP_PATH=`which sqlmap`
export GOPATH=~/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
    
# ensure Gruyere is running
cd ~/gauntlt
source ./run_site.sh

# check we're ready
cd ~/gauntlt
source ./ready_to_rumble.sh

# run the .attack files
cd ~/gauntlt
gauntlt
