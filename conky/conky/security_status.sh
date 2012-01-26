#!/bin/bash
curl -s "http://www.mcafee.com/us/threat_center/default.asp" | grep "Global Threat Condition" | sed -e 's/critical-image-date.*//' | sed -e s/'McAfee Labs'//g -e s/'Global Threat Condition'//g | sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | sed -e 's/^[ \t]*//' | sed 's/.$//' | tr -d '\n' | sed 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' > /tmp/mcafee

read STATUS < /tmp/mcafee

if [[ $STATUS = "LOW" ]]; then
echo "\${color5} \${font Webdings:size=9} d \${font}  " #GREEN
elif [[ $STATUS = "ELEVATED" ]]; then
echo "\${color6} \${font Webdings:size=9} d \${font}  " #YELLOW
elif [[ $STATUS = "SEVERE" ]]; then
echo "\${color7} \${font Webdings:size=9} d \${font}  " #ORANGE
elif [[ $STATUS = "CRITICAL" ]]; then
echo "\${color8} \${font Webdings:size=9} d \${font}  " #RED
else echo "\${color9}  \${font Webdings:size=9} d \${font}  " #BLUE
fi
