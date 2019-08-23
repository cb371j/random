#!/bin/bash
if ping -q -c 1 -W 1 -I vlan141 8.8.8.8
>/dev/null; then
  echo "IPv4 vlan141 is up"
else
  echo "IPv4 is down"
fi

if ping -q -c 1 -W 1 -I vlan144 controller-2
>/dev/null; then
  echo "IPv4 vlan144 is up"
else
  echo "IPv4 is down"
fi

if ping -q -c 1 -W 1 -I vlan142 controller-3
>/dev/null; then
  echo "IPv4 vlan142 is up"
else
  echo "IPv4 is down"
fi

