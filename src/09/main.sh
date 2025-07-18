#!/bin/bash

while true
do
    cpu_usage_1=$(cat /proc/loadavg | awk '{print $1}')
    cpu_usage_2=$(cat /proc/loadavg | awk '{print $2}')
    cpu_usage_3=$(cat /proc/loadavg | awk '{print $3}')

    filesystem_size_gb=$(df / | tail -1 | awk '{printf("%.2f", $2/1024/1024)}')
    filesystem_used_gb=$(df / | tail -1 | awk '{printf("%.2f", $3/1024/1024)}')
    filesystem_available_gb=$(df / | tail -1 | awk '{printf("%.2f", $4/1024/1024)}')

    #RAM
    memory_total_gb=$(free -m | awk '/Mem:/ {printf("%.2f", $2/1024)}')
    memory_used_gb=$(free -m | awk '/Mem:/ {printf("%.2f", $3/1024)}')
    memory_free_gb=$(free -m | awk '/Mem:/ {printf("%.2f", $4/1024)}')

    cat <<EOF > /usr/share/nginx/html/metrics/index.html
# HELP cpu_usage CPU usage
# TYPE cpu_usage gauge
cpu_usage_1 $cpu_usage_1
cpu_usage_2 $cpu_usage_2
cpu_usage_3 $cpu_usage_3

# HELP ram_usage RAM usage in gigabytes
# TYPE ram_usage gauge
memory_total_gb $memory_total_gb
memory_used_gb $memory_used_gb
memory_free_gb $memory_free_gb

# HELP disk_capacity Disk capacity in gigabytes
# TYPE disk_capacity gauge
filesystem_size_gb $filesystem_size_gb
filesystem_used_gb $filesystem_used_gb
filesystem_available_gb $filesystem_available_gb
EOF

    sleep 3
done &
