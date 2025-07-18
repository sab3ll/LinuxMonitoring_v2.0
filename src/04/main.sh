#!/bin/bash

source generators.sh

for ((i = 1; i < 6; i++)); do
    NGINX_LOG="nginx_${i}.log"
    log_generator "$NGINX_LOG"
done
