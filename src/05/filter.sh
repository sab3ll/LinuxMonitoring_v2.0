#!/bin/bash

#/home/sab3ll/Documents/s21_projects/DO4_LinuxMonitoring_v2.0-1/src/04/nginx_2.log

source checks.sh

begin_filter(){
    echo "Enter path to logfile:"
    read LOGFILE_PATH
    check_file_exists "$LOGFILE_PATH"
    case "$1" in
    "1" )
    awk '{print $9, $0}' "$LOGFILE_PATH" | sort -n | cut -d' ' -f2- > nginx_response.log
    ;;
    "2" )
    awk '{print $1}' "$LOGFILE_PATH" | sort -u > nginx_ip_unique.log
    ;;
    "3" )
    awk '$9 ~ /^4[0-9][0-9]|^5[0-9][0-9]$/' "$LOGFILE_PATH" > nginx_response_err.log
    ;;
    "4" )
    awk '$9 ~ /^4[0-9][0-9]|^5[0-9][0-9]$/{print $1}' ""$LOGFILE_PATH"" | sort -u > nginx_ip_unique_err.log
    ;;
esac
}
