#!/bin/bash


check_params_count() {
if [ "$#" -ne 3 ]; then
    echo "Error: script requires 3 parameters"
    echo "Usage: $0 <folder_letters> <file_letters.file_extension> <file_size>Mb" >&2;
    exit 1
fi
}

check_numeric() {
if ! [[ "$1" =~ ^[[:digit:]]+$ ]]; then
    echo "Error: <$1> is not a number." >&2;
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
    echo "Error: Size of the argument <$1> must be less than $2 Mb." >&2;
    exit 1
fi
}


begin_check() {

local ARGS_AMOUNT=$@
local DIR_NAME=$1
local FILENAME=$2
local FILESIZE=$3

local DIR_NAME_LIM="7"
local FILE_NAME_LIM="7"
local FILE_EXT_LIM="3"
local FILE_SIZE_LIM="100"

check_params_count $ARGS_AMOUNT
check_letters $DIR_NAME
check_length $DIR_NAME $DIR_NAME_LIM
check_format $FILENAME
local FILE_NAME="${FILENAME%.*}"
local FILE_EXT="${FILENAME##*.}"
check_length $FILE_NAME $FILE_NAME_LIM
check_length $FILE_EXT $FILE_EXT_LIM
local FILE_SIZE=$(echo $FILESIZE | grep -oE '[0-9]+')
check_size $FILE_SIZE $FILE_SIZE_LIM

}
