#!/bin/sh

PLATFORM="$(uname)"

if [ "$PLATFORM" = "FreeBSD" ]; then
    #vmstat -h | tail -1 | awk 'BEGIN {OFS=","} {print "Mem:" $4,$5}'
    top -b | grep 'Mem:' | sed -e 's/G//g' -e 's/M//g' -e 's/K//g' | awk '{for(i=2;i<=10;i=i+2) {if ($i>1024) {if (i<6) {u=u+int($i/1024)} else {f=f+int($i/1024)}} else {if (i<6) {u=u+$i} else {f=f+$i}}}} END {OFS="M,";ORS="M\n";print "Mem:" u,f}'
elif [ "$PLATFORM" = "Linux" ]; then
    free -m | awk 'buffers/cache:' | tr -s ' ' | awk 'BEGIN {OFS="M,"; ORS="M\n"} {print "Mem:" $3,$4}'
else
    echo "Mem:Unkonw platform"
fi
