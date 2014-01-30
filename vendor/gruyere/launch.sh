#! /usr/bin/env bash
rm -rf ./source
mkdir ./source
cd ./source
unzip ../gruyere-code.zip
python gruyere.py > /dev/null 2>&1 &
GRUYERE_PID=$!
cd ..
echo $GRUYERE_PID >pid

