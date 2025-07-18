#!/bin/bash


check_params_count() {
if [ "$#" -ne 6 ]; then
    echo "Error: script requires 6 parameters"
    echo "Usage: $0 <absolute_path> <num_subfolders> <folder_letters> <num_files> <file_letters.file_extension> <file_size>kb" >&2;
    exit 1
fi
}

check_absolute_path() {
if [ ! -d $1 ]; then
    echo "Error: Absolute path does not exist." >&2;
    exit 1
fi
}

check_numeric() {
if ! [[ "$1" =~ ^[[:digit:]]+$ ]]; then
    echo "Error: <$1> is not a number." >&2;
    exit 1
fi
}

check_pos() {
if ! [[ $1 -gt 0 ]]; then
    echo "Error: argument <$1> is invalid" >&2;
    exit 1
fi
}

check_letters() {
if ! [[ "$1" =~ ^[a-zA-Z]+$ ]]; then
    echo "Argument <$1> does not match the pattern [a-zA-Z]" >&2;
    exit 1
fi
}

check_length() {
if [[ "${#1}" -gt $2 ]]; then
    echo "Error: Length of the argument <$1> must be less than $2 characters." >&2;
    exit 1
fi
}

check_format() {
if ! [[ "$1" =~ ^[a-zA-Z]+\.[a-zA-Z]+$ ]]; then
    echo "Error: Argument <$1> does not match the pattern [a-zA-Z].[a-zA-Z]." >&2;
    exit 1
fi
}

check_size() {
if [[ "$1" -gt $2 ]]; then
    echo "Error: Size of the argument <$1> must be less than $2 KB." >&2;
    exit 1
fi
}


begin_check() {

local ARGS_AMOUNT=$@
local ABS_PATH=$1
local DIR_AMOUNT=$2
local DIR_NAME=$3
local FILE_AMOUNT=$4
local FILENAME=$5
local FILESIZE=$6

local DIR_NAME_LIM="7"
local FILE_NAME_LIM="7"
local FILE_EXT_LIM="3"
local FILE_SIZE_LIM="100"

check_params_count $ARGS_AMOUNT
check_absolute_path $ABS_PATH
check_numeric $DIR_AMOUNT
check_pos $DIR_AMOUNT
check_letters $DIR_NAME
check_length $DIR_NAME $DIR_NAME_LIM
check_numeric $FILE_AMOUNT
check_pos $FILE_AMOUNT
check_format $FILENAME
local FILE_NAME="${FILENAME%.*}"
local FILE_EXT="${FILENAME##*.}"
check_length $FILE_NAME $FILE_NAME_LIM
check_length $FILE_EXT $FILE_EXT_LIM
local FILE_SIZE=$(echo $FILESIZE | grep -oE '[0-9]+')
check_size $FILE_SIZE $FILE_SIZE_LIM

}
