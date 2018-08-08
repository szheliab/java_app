#!/usr/bin/env bash

# ip adddr

ip=$(ifconfig enp0s3 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')

# full ip

f_ip="$ip"":8181/health"

answer=$(head -n1 <(curl -I 10.28.12.215:8383/health/ 2> /dev/null))
echo $answer
