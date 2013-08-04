#!/bin/sh

uptime | cut -d, -f1 | sed 's/^  *//g' | tr -s ' ' | cut -d' ' -f2-

