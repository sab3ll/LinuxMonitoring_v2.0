#!/bin/bash

source checks.sh
source generators.sh

START_TIME=$(date +%s)

begin_check $@
dir_list_generator

while ! df -h / | awk 'NR==2 {print $4}' | grep -q 'M'; do
    dir_generator $@
done
