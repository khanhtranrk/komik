#!/bin/bash
set -e

rm -f /komik/tmp/pids/server.pid

exec "$@"
