#!/bin/bash
#shutdown ceph (shutdown osds, monitors, admin)
kubectl exec -it -n ceph ceph-mon-8rl5q ceph osd set noout
kubectl exec -it -n ceph ceph-mon-8rl5q ceph osd set nobackfill
kubectl exec -it -n ceph ceph-mon-8rl5q ceph osd set norecover
kubectl exec -it -n ceph ceph-mon-8rl5q ceph osd set norebalance
kubectl exec -it -n ceph ceph-mon-8rl5q ceph osd set nodown
kubectl exec -it -n ceph ceph-mon-8rl5q ceph osd set pause
kubectl drain aknode111 --ignore-daemonsets --delete-local-data.
kubectl drain aknode110 --ignore-daemonsets --delete-local-data.

