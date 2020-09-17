#!/bin/bash
set -euo pipefail
t=5s
echo "Running reproducer for CVE-2020-14386 in ${t} - this may crash the node"
sleep $t
if ! /usr/bin/cve-2020-14386; then
    echo 'Reproducer failed!' 1>&2
    exit 1
fi
sleep 5
echo "Reproducer exited successfully - node probably not vulnerable"


