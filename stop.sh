#!/bin/bash
# Dapatkan PID skrip shell
pid=$(pgrep -f MainCore.sh)

# Hentikan skrip shell berdasarkan PID
kill $pid
