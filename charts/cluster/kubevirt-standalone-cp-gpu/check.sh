#!/bin/bash

# check template's args applying
function gen() {
  # Base params
  local base_args=(
    --namespace test-ns
    --set 'worker.cpus=2'
    --set 'worker.memory=4Gi'
    --set controlPlane.cpus=2
  )

  # data volumes
  local data_volumes_args=(
    --set 'worker.dataVolumes[0].name=test-dv'
    --set 'worker.dataVolumes[0].accessModes=ReadWriteOnce'
    --set 'worker.dataVolumes[0].storage=10Gi'
    --set 'worker.dataVolumes[0].volumeMode=Filesystem'
    --set 'worker.dataVolumes[0].storageClassName=local-path'
    --set 'worker.dataVolumes[0].source.http.url=https://example.com/image.img'
#    --set 'worker.dataVolumes[0].bindImmediate=true'
  )

  # SRIOV params
  local sriov_args=(
    --set 'worker.additionalSriovMultusNADs[0].name=sriov-net'
    --set 'worker.additionalSriovMultusNADs[0].namespacedAddress=default/sriov-network-pf0vf0'
    --set 'controlPlane.additionalSriovMultusNADs[0].name=sriov-net'
#    --set 'controlPlane.additionalSriovMultusNADs[0].namespacedAddress=default/sriov-network-pf0vf1'
    --set 'cluster.multusSriovNADs[0].config={"type":"sriov","cniVersion":"1.0.0","name":"custom-sriov","logLevel":"info","logFile":"/var/log/custom-sriov.log"}'
  )

  # NAD
  local nad_args=(
    --set 'cluster.multusSriovNADs[0].name=sriov-network-pf0vf0'
    --set 'cluster.multusSriovNADs[0].resourceName=xxxx/pf0_vf0'
  )


  helm template test-local ./ "${base_args[@]}" "${data_volumes_args[@]}" "${sriov_args[@]}" "${nad_args[@]}" > test-local.yaml
}

"$@"


