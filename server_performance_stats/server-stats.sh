#!/bin/bash

# Get the Total CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Total memory usage (Free vs Used including percentage)
mem_usage=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')

# otal disk usage (Free vs Used including percentage)
disk_usage=$(df -h | awk '$NF=="/"{printf "%s", $5}')

# get the Top 5 processes by CPU usage
top_processes=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6)

# get the Top 5 processes by Memory usage
top_mem_processes=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6)

# get the failed login attempts and users
failed_logins=$(cat /var/log/auth.log | grep "Failed password" | awk '{print $1, $2, $11, $13}')

