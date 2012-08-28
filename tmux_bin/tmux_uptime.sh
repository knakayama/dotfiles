#!/bin/bash

uptime | tr -s ' ' | cut -d' ' -f3-5 | sed 's/,//'

