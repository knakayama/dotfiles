#!/bin/bash

uptime | cut -d, -f1 | tr -s ' ' | cut -d' ' -f3-

