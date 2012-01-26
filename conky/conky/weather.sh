#!/bin/sh
cd ~/.conky
wget -O .weather2 http://weather.yahoo.com/greece/attiki/athens-946738/?unit=c -o /dev/null
grep yw-forecast .weather2 > .weather;
html2text  .weather > .weather2;
sed -n 1,4p .weather2 > .weather;
sed -n 13,18p .weather2 >> .weather;
sed -n 20p .weather2 >> .weather;
./cutweather.py;
cat weather;
rm .weather weather .weather2;
