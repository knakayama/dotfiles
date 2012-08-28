#!/bin/bash

uptime | tr -s ' ' | cut -d' ' -f10- | sed 's/, / /g'

