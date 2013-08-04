#!/bin/sh

PLATFORM="$(uname)"

if [ "$PLATFORM" = "FreeBSD" ]; then
    #vmstat -h | tail -1 | awk 'BEGIN {OFS=","} {print "Mem:" $4,$5}'
    top -b | grep 'Mem:' | sed -e 's/G//g' -e 's/M//g' -e 's/K//g' | awk 'BEGIN{OFS="M,"; ORS="M\n"} {print "Mem:" $2+$4+$6,$8+$10}'
elif [ "$PLATFORM" = "Linux" ]; then
    free -m | awk 'buffers/cache:' | tr -s ' ' | awk 'BEGIN {OFS="M,"; ORS="M\n"} {print "Mem:" $3,$4}'
else
    echo "Mem:Unkonw platform"
fi
