#!/bin/bash

ps auxfww | grep -vE 'ps|grep' | tail -n +2 | wc -l
#top -b -n 1 | grep 'Tasks' | tr -s ' ' | cut -d' ' -f2

