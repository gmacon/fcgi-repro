#!/bin/sh

if ! [ -d env ]; then
    python3 -m venv env
    ./env/bin/python -m pip install flup
fi

./env/bin/python server.py >server.log 2>&1 &
server_pid=$!

caddy version >caddy.log
caddy build-info >>caddy.log
caddy run >>caddy.log 2>&1 &
caddy_pid=$!

tcpdump -i lo -w repro.pcap tcp port 65535 >tcpdump.log 2>&1 &
tcpdump_pid=$!

sleep 1
curl --trace-ascii % --max-time 5 http://127.0.0.1:8080/

kill $tcpdump_pid
kill $caddy_pid
kill $server_pid
