#!/usr/bin/env bash

set -e

#disabled since we are deploying a snapshot version
#cd ../../bin
#. ./setVersions.sh
#cd -

export INGESTION_MANAGER_VERSION=1.0.0-SNAPSHOT

export IMAGE_URI=registry.daf.teamdigitale.it/daf-ingestion-manager:${INGESTION_MANAGER_VERSION}

# test for template
envsubst < daf_ingestion_manager.yml > output.yml

kubectl $KUBECONF_LOCATION apply -f output.yml
