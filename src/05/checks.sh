#!/bin/bash


check_params_count() {
if [ "$#" -ne 1 ]; then
    echo "Error: script requires 1 parameter." >&2;
    echo "Usage: $0 <filter_method>"
    echo -e "Methods:\n1 - sort by response code;\n2 - print unique IPs;\n3 - print requests with errors;\n4 - print unique IPs from requests with errors."
    exit 1
fi
}

check_method_number() {
if ! [[ "$1" =~ [1-4] ]]; then
    echo "Error: there is no such filter method." >&2;
    echo -e "Methods:\n1 - sort by response code;\n2 - print unique IPs;\n3 - print requests with errors;\n4 - print unique IPs from requests with errors."
    exit 1
fi
}

check_file_exists() {
if [ ! -f $1 ]; then
    echo "Error: logfile does not exist." >&2;
    exit 1
fi
}

begin_check() {
    check_params_count $@
    check_method_number $1
}
