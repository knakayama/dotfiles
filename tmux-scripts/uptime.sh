#!/bin/sh

#uptime | cut -d, -f1 | sed 's/^  *//g' | tr -s ' ' | cut -d' ' -f2-
#uptime | perl -lne 's/(\s){2,}/\1/g; print $1 if /(up.+?),/'
uptime | tr -s ' ' | perl -wlne 'print $1 if /(up.+?),/'

