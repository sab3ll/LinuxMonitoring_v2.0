#!/bin/bash

source checks.sh

clean_logfile(){
echo "Enter absolute path to logfile:"
read ABSOLUTE_PATH
check_file_exists $ABSOLUTE_PATH
awk '{if (NF == 3) print $1}' $ABSOLUTE_PATH | xargs -I {} rm -rf {}
}

clean_date(){
echo "Enter start time in YYYY-MM-DD HH:MM:SS format:"
read START_DATETIME
check_datetime $START_DATETIME
echo "Enter end time in YYYY-MM-DD HH:MM:SS format:"
read END_DATETIME
check_datetime $END_DATETIME
check_dates_order "$START_DATETIME" "$END_DATETIME"
find / -type d -newerct "$START_DATETIME" ! -newerct "$END_DATETIME" -exec ls -ld {} \; | awk '$2 == 2' | awk '{print $NF}' | xargs -I {} rm -rf {}
}

clean_regexp(){
echo "Enter regexp for in format [a-zA-Z]_DDMMYY"
read REGEXP
REGEXP_DATE=$(echo "$REGEXP" | cut -d'_' -f2)
check_regexp "$REGEXP" "$REGEXP_DATE"
find / -type d -regex ".*/[a-zA-Z]+_$REGEXP_DATE$" | xargs -I {} rm -rf {}
}

begin_clean(){
    case "$1" in
    "1" )
    clean_logfile
    ;;
    "2" )
    clean_date
    ;;
    "3" )
    clean_regexp
    ;;
esac
}
