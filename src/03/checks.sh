#!/bin/bash


check_params_count() {
if [ "$#" -ne 1 ]; then
    echo "Error: script requires 1 parameter." >&2;
    echo "Usage: $0 <cleaning_method>"
    echo -e "Methods:\n1 - clean by logfile;\n2 - clean by creation date;\n3 - clean by regexp."
    exit 1
fi
}

check_method_number() {
if ! [[ "$1" =~ [1-3] ]]; then
    echo "Error: there is no such cleaning method." >&2;
    echo -e "Methods:\n1 - clean by logfile;\n2 - clean by creation date;\n3 - clean by regexp."
    exit 1
fi
}

check_file_exists() {
if [ ! -f $1 ]; then
    echo "Error: logfile does not exist." >&2;
    exit 1
fi
}

check_regexp() {
if [[ ! $1 =~ ^[a-zA-Z]+_[0-9]{6}$ ]]; then
    echo "Error: Argument <$1> does not match the pattern [a-zA-Z]_DDMMYY." >&2;
    exit 1
fi
if ! date -d "${2:4:2}${2:2:2}${2:0:2}" >/dev/null 2>&1; then
    echo "Error: Date does not match the pattern DDMMYY." >&2;
    exit 1
fi
}

check_datetime() {
if ! date -d "$1" &>/dev/null; then
    echo "Error: Invalid date format." >&2;
    exit 1
fi
}

check_dates_order() {
if [[ $(date -d "$1" +%s) -gt $(date -d "$2" +%s) ]]; then
    echo "Error: Start date is later than end date." >&2;
    exit 1
fi
}

begin_check() {
    check_params_count $@
    check_method_number $1
}
