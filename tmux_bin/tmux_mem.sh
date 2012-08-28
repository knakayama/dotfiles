#!/bin/bash

get_total_mem_size() {
    local total_mem_size=$(free -h | grep 'Mem:' | tr -s ' ' | cut -d' ' -f2)

    echo "$total_mem_size"
}

get_used_free_mem_size() {
    local used_free_mem_size=$(free -h | grep 'buffers/cache:' | tr -s ' ' | cut -d' ' -f3,4)

    echo "$used_free_mem_size"
}

get_mem_size() {
    local total_mem_size=$(get_total_mem_size)
    local used_free_mem_size=$(get_used_free_mem_size)

    echo "$total_mem_size $used_free_mem_size"
}

mem_size=$(get_mem_size)

echo "$mem_size"

