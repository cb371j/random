#!/bin/bash
KEYSTONE_IMAGE=docker.io/openstackhelm/keystone:ocata

  TOKEN=`sudo docker run --rm --net=host -e OS_AUTH_URL=http://keystone-api.ucp.svc.cluster.local:80/v3 -e OS_PROJECT_DOMAIN_NAME=default -e OS_USER_DOMAIN_NAME=default -e OS_PROJECT_NAME=service -e OS_REGION_NAME=cluster17RegionOne -e OS_USERNAME=drydock -e OS_PASSWORD=86db58e20de93ef55477 -e OS_IDENTITY_API_VERSION=3 ${KEYSTONE_IMAGE} openstack token issue -f value -c id`
echo PAUSE
 # curl -v -X DELETE -H "X-AUTH-TOKEN: $TOKEN" -H 'Content-Type: application/x-yaml' http://deckhand-int.ucp.svc.cluster.local:9000/api/v1.0/revisions

