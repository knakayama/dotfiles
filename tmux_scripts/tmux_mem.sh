#!/bin/sh

PLATFORM="$(uname)"

if [ "$PLATFORM" = "FreeBSD" ]; then
    #top -b | grep 'Mem:' | sed 's/M//g' | awk 'BEGIN{OFS="M,"; ORS="M\n"} {used=$2+$4+9; print "Mem:"$6,used}'
    vmstat -h | tail -1 | awk 'BEGIN {OFS=","} {print "Mem:" $4,$5}'
elif [ "$PLATFORM" = "Linux" ]; then
    free -m | awk 'buffers/cache:' | tr -s ' ' | awk 'BEGIN {OFS="M,"; ORS="M\n"} {print "Mem:" $3,$4}'
else
    echo "Unkonw platform"
fi
