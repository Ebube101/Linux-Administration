#!/bin/bash


# Identify top resource-consuming processes
ps aux --sort=-%mem | head -10  # Top 10 memory consumers
ps aux --sort=-%cpu | head -10  # Top 10 CPU consumers

# Check disk usage
df -h
du -sh /var/log/*  # Check log file sizes

# Monitor system logs in real-time
sudo tail -f /var/log/syslog

