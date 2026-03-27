#!/bin/bash

# check template's args applying
function sriov() {
  # Base params
  local base_args=(
    --namespace test-ns
    --set 'worker.cpus=2'
    --set 'worker.memory=4Gi'
    --set controlPlane.cpus=2
    --set 'worker.dataVolumes[0].name=test-dv'
    --set 'worker.dataVolumes[0].accessModes=ReadWriteOnce'
    --set 'worker.dataVolumes[0].storage=10Gi'
    --set 'worker.dataVolumes[0].volumeMode=Filesystem'
    --set 'worker.dataVolumes[0].storageClassName=local-path'
    --set 'worker.dataVolumes[0].source.http.url=https://example.com/image.img'
  )

  # SRIOV params
  local sriov_args=(
    --set 'worker.additionalSriovMultusNADs[0].name=sriov-net'
    --set 'worker.additionalSriovMultusNADs[0].namespacedAddress=default/sriov-network-pf0vf0'
    --set 'controlPlane.additionalSriovMultusNADs[0].name=sriov-net'
    --set 'controlPlane.additionalSriovMultusNADs[0].namespacedAddress=default/sriov-network-pf0vf1'
  )

  helm template test-local ./ "${base_args[@]}" "${sriov_args[@]}" > test1-worker-without-sriov.yaml
}

"$@"


