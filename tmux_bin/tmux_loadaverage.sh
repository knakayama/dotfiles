#!/bin/bash

#uptime | tr -s ' ' | cut -d' ' -f10- | sed 's/, / /g'
uptime | tr -s ' ' | cut -d' ' -f10- | sed 's/ //g'

