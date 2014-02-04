#! /usr/bin/env bash
cd ./source
python gruyere.py > /dev/null 2>&1 &
GRUYERE_PID=$!
cd ..
echo $GRUYERE_PID >gruyere.pid
echo "Gruyere started at $GRUYERE_PID"
