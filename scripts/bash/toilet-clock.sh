#!/usr/local/bin/bash

clear
while sleep 1; do
    d=$(date +"%H:%M:%S")
    e=$(echo "toilet -t -f mono12 $d")
    tput setaf 1 cup 0
    eval $e
    tput setaf 4 cup 8
    eval "$e -F flop"
    tput cup 0
done
