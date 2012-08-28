#!/bin/bash

free -h | grep 'buffers/cache:' | tr -s ' ' | cut -d' ' -f3,4 --output-delimiter=,

