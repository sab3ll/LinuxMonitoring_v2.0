#!/bin/bash


dir_list_generator()
{
LOG_DIRLIST="dir_list.log"
find / -type d ! -path "*/bin*" ! -path "*/sbin*" ! -path "*/run*" 2>/dev/null > $LOG_DIRLIST
}

calculate_time(){
local END_TIME=$(date +%s)
local EXEC_TIME=$((END_TIME - $1))
local START_DATETIME=$(date -d "@$START_TIME" +"%Y-%m-%d %H:%M:%S")
local END_DATETIME=$(date -d "@$END_TIME" +"%Y-%m-%d %H:%M:%S")
local LOG_DATETIME="datetime.log"

echo "Execution started: $START_DATETIME" | tee -a "$LOG_DATETIME"
echo "Execution ended:   $END_DATETIME" | tee -a "$LOG_DATETIME"
echo "Execution lasted:             $(date -u -d "@$EXEC_TIME" +"%H:%M:%S")" | tee -a "$LOG_DATETIME"
echo ""
}

dir_generator() {
local ABS_PATH=$(shuf -n 1 $LOG_DIRLIST)
local DIR_AMOUNT=$((RANDOM % 10 + 1))
local STR=$1
local STRLEN=${#1}

#echo "Dir name:$ABS_PATH"
#echo "Dir amount:$DIR_AMOUNT"

local MULT=2
local MULT_INDEX=0
local DIR_COUNTER=1
local LAUNCH_DATE=$(date +_%d%m%y)

if [[ STRLEN -lt 5 ]]; then
    MULT=6-$STRLEN
    DIR_COUNTER=0
else
    FOLDER_NAME="${STR}${LAUNCH_DATE}"
    if mkdir -p "$ABS_PATH/$FOLDER_NAME" ; then
        echo "$ABS_PATH/$FOLDER_NAME" $(date +%d.%m.%y\ %H:%M:%S) >> output.log
        file_generator $2 $3 "$ABS_PATH/$FOLDER_NAME"
    else
        return 1
    fi
fi

for (( k = $DIR_COUNTER; k < DIR_AMOUNT; k++ )); do
    if [[ MULT_INDEX -eq STRLEN ]]; then
        MULT_INDEX=0
        ((MULT++))
    fi
    FOLDER_NAME=""
    for (( i = 0; i < STRLEN; i++ )); do
        if [[ $i -eq $MULT_INDEX ]]; then
            for (( j = 0; j < $MULT; j++ )); do
                FOLDER_NAME+="${STR:i:1}"
            done
        else
            FOLDER_NAME+="${STR:i:1}"
        fi
    done
    FOLDER_NAME+=${LAUNCH_DATE}
    ((MULT_INDEX++))
    if mkdir -p "$ABS_PATH/$FOLDER_NAME" ; then
        echo "$ABS_PATH/$FOLDER_NAME" $(date +%d.%m.%y\ %H:%M:%S) >> output.log
        file_generator $2 $3 "$ABS_PATH/$FOLDER_NAME"
    else
        return 1
    fi
done
}

file_generator() {
local FILE_AMOUNT=$((RANDOM % 20 + 1))
local FILENAME=$1
local FILESIZE=$2
local ABS_PATH=$3
#echo "File amount:$FILE_AMOUNT"

local FILE_NAME="${FILENAME%.*}"
local FILE_EXT="${FILENAME##*.}"
local FILE_SIZE=$(echo $FILESIZE | grep -oE '[0-9]+')
local FILE_NAME_LEN=${#FILE_NAME}

local MULT=2
local MULT_INDEX=0
local FILE_COUNTER=1
local LAUNCH_DATE=$(date +_%d%m%y)

if [[ FILE_NAME_LEN -lt 5 ]]; then
    MULT=6-$FILE_NAME_LEN
    FILE_COUNTER=0
else
    GEN_FILE_NAME="${FILE_NAME}.${FILE_EXT}${LAUNCH_DATE}"
    echo "$ABS_PATH/$GEN_FILE_NAME" $(date +%d.%m.%y\ %H:%M:%S) $FILESIZE >> output.log
    dd if=/dev/zero of="$ABS_PATH/$GEN_FILE_NAME" bs=1048576 count=$FILE_SIZE > /dev/null 2>&1

fi

for (( l = $FILE_COUNTER; l < FILE_AMOUNT; l++ )); do
    if [[ MULT_INDEX -eq FILE_NAME_LEN ]]; then
        MULT_INDEX=0
        ((MULT++))
    fi
    if df -h / | awk 'NR==2 {print $4}' | grep -q 'M'; then
        calculate_time $START_TIME
        exit 0
    fi
    GEN_FILE_NAME=""
    for (( i = 0; i < FILE_NAME_LEN; i++ )); do
        if [[ $i -eq $MULT_INDEX ]]; then
            for (( j = 0; j < $MULT; j++ )); do
                GEN_FILE_NAME+="${FILE_NAME:i:1}"
            done
        else
            GEN_FILE_NAME+="${FILE_NAME:i:1}"
        fi
    done
    GEN_FILE_NAME+=.${FILE_EXT}${LAUNCH_DATE}
    ((MULT_INDEX++))
    echo "$ABS_PATH/$GEN_FILE_NAME" $(date +%d.%m.%y\ %H:%M:%S) $FILESIZE >> output.log
    dd if=/dev/zero of="$ABS_PATH/$GEN_FILE_NAME" bs=1048576 count=$FILE_SIZE > /dev/null 2>&1
done
}
