#!/bin/bash

#uptime | tr -s ' ' | cut -d' ' -f9- | sed 's/, / /g'
uptime | tr -s ' ' | cut -d' ' -f9- | sed 's/ //g'

