#!/bin/bash


dir_generator() {
local ABS_PATH=$1
local DIR_AMOUNT=$2
local STR=$3
local STRLEN=${#3}

local MULT=2
local MULT_INDEX=0
local DIR_COUNTER=1
local LAUNCH_DATE=$(date +_%d%m%y)

if [[ STRLEN -lt 4 ]]; then
    MULT=5-$STRLEN
    DIR_COUNTER=0
else
    FOLDER_NAME="${STR}${LAUNCH_DATE}"
    echo "$ABS_PATH/$FOLDER_NAME" $(date +%d.%m.%y\ %H:%M:%S) >> output.log
    mkdir "$ABS_PATH/$FOLDER_NAME"
    file_generator $4 $5 $6 "$ABS_PATH/$FOLDER_NAME"
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
    echo "$ABS_PATH/$FOLDER_NAME" $(date +%d.%m.%y\ %H:%M:%S) >> output.log
    mkdir "$ABS_PATH/$FOLDER_NAME"
    file_generator $4 $5 $6 "$ABS_PATH/$FOLDER_NAME"
done
}

file_generator() {
local FILE_AMOUNT=$1
local FILENAME=$2
local FILESIZE=$3
local ABS_PATH=$4

local FILE_NAME="${FILENAME%.*}"
local FILE_EXT="${FILENAME##*.}"
local FILE_SIZE=$(echo $FILESIZE | grep -oE '[0-9]+')
local FILE_NAME_LEN=${#FILE_NAME}

local MULT=2
local MULT_INDEX=0
local FILE_COUNTER=1
local LAUNCH_DATE=$(date +_%d%m%y)

if [[ FILE_NAME_LEN -lt 4 ]]; then
    MULT=5-$FILE_NAME_LEN
    FILE_COUNTER=0
else
    GEN_FILE_NAME="${FILE_NAME}.${FILE_EXT}${LAUNCH_DATE}"
    echo "$ABS_PATH/$GEN_FILE_NAME" $(date +%d.%m.%y\ %H:%M:%S) $FILESIZE >> output.log
    dd if=/dev/zero of="$ABS_PATH/$GEN_FILE_NAME" bs=1024 count=$FILE_SIZE > /dev/null 2>&1

fi

for (( l = $FILE_COUNTER; l < FILE_AMOUNT; l++ )); do
    if [[ MULT_INDEX -eq FILE_NAME_LEN ]]; then
        MULT_INDEX=0
        ((MULT++))
    fi
    if df -h / | awk 'NR==2 {print $4}' | grep -q 'M'; then
        echo "Generating has been stopped, there is not enough space in root directory"
        exit 1
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
    dd if=/dev/zero of="$ABS_PATH/$GEN_FILE_NAME" bs=1024 count=$FILE_SIZE > /dev/null 2>&1
done
}
