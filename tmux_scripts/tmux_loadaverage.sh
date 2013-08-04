#!/bin/sh

uptime | egrep -o '([0-9]*\.[0-9]{2}\, ){2}[0-9]*\.[0-9]{2}' | sed 's/  *//g' | awk '{print "Avg:" $0}'

