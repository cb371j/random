#!/bin/bash

NAMESPACE=ceph

set -xe

function check_mon_dns {
  DNS_CHECK=$(getent hosts ceph-mon | head -n1)
  PODS=$(kubectl get pods --namespace=${NAMESPACE} --selector=application=ceph --field-selector=status.phase=Running --output=jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | grep -E 'ceph-mon|ceph-osd|ceph-mgr|ceph-mds')
  ENDPOINT=$(kubectl get endpoints ceph-mon -n ${NAMESPACE} -o json | awk -F'"' -v port=${MON_PORT} '/ip/{print $4":"port}' | paste -sd',')

  if [[ ${PODS} == "" || ${ENDPOINT} == "" ]]; then
    echo "Something went wrong, no PODS or ENDPOINTS are available!"
  elif [[ ${DNS_CHECK} == "" ]]; then
    for POD in ${PODS}; do
      kubectl exec -t ${POD} --namespace=${NAMESPACE} -- \
      sh -c -e "/tmp/utils-checkDNS.sh ${ENDPOINT}"
    done
  else
    for POD in ${PODS}; do
      kubectl exec -t ${POD} --namespace=${NAMESPACE} -- \
      sh -c -e "/tmp/utils-checkDNS.sh up"
    done
  fi
}

function watch_mon_dns {
  while [ true ]; do
    echo "checking DNS health"
    check_mon_dns || true
    echo "sleep 300 sec"
    sleep 300
  done
}

watch_mon_dns

exit
root@ak
