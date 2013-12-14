#!/bin/sh

#uptime | grep -Eo '([0-9]*\.[0-9]{2}\, ){2}[0-9]*\.[0-9]{2}' | sed 's/  *//g' | awk '{print "Avg:" $0}'
uptime | perl -ne 's/\s+//g; printf "Avg:%s\n",$1 if /average:(.*)/'
#uptime | tr -d ' ' | perl -ne 'printf "Avg:%s\n",$1 if /((\d+\.\d{2},?){3})/'

