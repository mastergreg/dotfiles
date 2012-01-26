#!/bin/sh
var=$( amixer get Master | grep "Front Left:" | awk '{print $5}' | grep -oE "[[:digit:]]{1,}")
var2=$(($var / 1))
echo $var2
