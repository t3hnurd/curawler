#!/bin/bash

# Test for an IP list
if [ -z "$1" ]; then
  echo "An IP address list must be supplied. Exiting...";
  exit 1;
fi

# Expand the IP list and test HTTP/HTTPS on each line
# Expects lines in the format "IP:PORT"
for i in $(cat $1 | sort -R); do
  ip=$(echo $i | cut -d':' -f1); port=$(echo $i | cut -d':' -f2);
  echo "Trying ${i}...";
  for pre in http:// https://; do
    echo "# ${pre} request" >> ${ip}_${port}_curl.txt;
        curl -ILksS -m 10 -A 'Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0' ${pre}${i} &>> ${ip}_${port}_curl.txt;
        sleep $(( (RANDOM % 10) + 1 ));
  done;
done;
