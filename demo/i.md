curl -s https://fluxcd.io/install.sh | sudo bash

flux bootstrap github \
--token-auth \
--owner=kozmod \
--repository=helm-charts \
--branch=main \
--path=templates/cluster \
--personal

kubectl get gitrepository -A

https://fluxcd.io/flux/installation/bootstrap/github/
https://fluxcd.io/flux/components/source/gitrepositories/

---

helm show chart oci://ghcr.io/pbasov/oot/charts/kubevirt-standalone-cp --version 1.4.0
helm show all oci://ghcr.io/pbasov/oot/charts/kubevirt-standalone-cp --version 1.4.0
helm show values oci://ghcr.io/pbasov/oot/charts/kubevirt-standalone-cp --version 1.4.0

helm show chart oci://ghcr.io/kozmod/helm-charts/kcustom-remote-cluster --version 0.1.0

```yaml
---

  cat << EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: k0rdent-ssh
  EOF

cat > remote-ssh-key-secret.yaml << EOF
apiVersion: v1
data:
  value: LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUJsd0FBQUFkemMyZ3RjbgpOaEFBQUFBd0VBQVFBQUFZRUF6azhVMlVXazNJS0l0UElhU2JHUEs1UDNtOXV3SWtxaEZyZkdRRGxKL3RKOG9LNEZINFptCmhQS0hzY0FFS3JGbVhENk9OWlZRSXU5emVsRHB5eFl2SUVLbUppMWdkTUZ6OEYwTGRUR1NhY0lMbGFFUUJnemh4L0E5ejMKOW1lUTlLTzVham9OaDMrYS9kcG5qYlJoMWY4anoxOFptaDRvWHA2azlqWjFUTFVLVGVaODZuYzZZYmhBbWdaOWcwUExtRApicVRnQ0VycUpoLytUbDgzbnZVRlBadG5DOFpxUVRmWDZwRG0wdzNCUUtHK0w4MkxrejdEc2VrY2JUOG10SHJlcFNTV0NsCmIzUnRYVGIvM3pFOFhmWU9qSEN4RThXNE83WVR2d0tHTkg4Vmp4dm5QeGowTnJEUDNRME9Ia1kvSTVKc3BNL1lMZUlmN0YKcUdCWEt0S2R0MVhXd2dXS0RmRE5XNDZOWVNoQXJQWUhvenpCbGhQZ08vWEdXek9CWTgwVEJpSTVpNE9INWVRVElLNEcyMgpFYmp0eitIc1RhMlFTcEdWcnFXN0JYUTBjMjdnNnArMVQ1K3FHRzFmYWllL0hsYTdNR2FDMGs4S2t1dkhHYjJrMm5GV3RNCmlJYUVnNmFNMGxCL3BCSmxHUGk5WU9qTldBSmJYRUNSRTRaZWFkb0hBQUFGa0ttMmh2bXB0b2I1QUFBQUIzTnphQzF5YzIKRUFBQUdCQU01UEZObEZwTnlDaUxUeUdrbXhqeXVUOTV2YnNDSktvUmEzeGtBNVNmN1NmS0N1QlIrR1pvVHloN0hBQkNxeApabHcrampXVlVDTHZjM3BRNmNzV0x5QkNwaVl0WUhUQmMvQmRDM1V4a21uQ0M1V2hFQVlNNGNmd1BjOS9abmtQU2p1V282CkRZZC9tdjNhWjQyMFlkWC9JODlmR1pvZUtGNmVwUFkyZFV5MUNrM21mT3AzT21HNFFKb0dmWU5EeTVnMjZrNEFoSzZpWWYKL2s1Zk41NzFCVDJiWnd2R2FrRTMxK3FRNXRNTndVQ2h2aS9OaTVNK3c3SHBIRzAvSnJSNjNxVWtsZ3BXOTBiVjAyLzk4eApQRjMyRG94d3NSUEZ1RHUyRTc4Q2hqUi9GWThiNXo4WTlEYXd6OTBORGg1R1B5T1NiS1RQMkMzaUgreGFoZ1Z5clNuYmRWCjFzSUZpZzN3elZ1T2pXRW9RS3oyQjZNOHdaWVQ0RHYxeGxzemdXUE5Fd1lpT1l1RGgrWGtFeUN1QnR0aEc0N2MvaDdFMnQKa0VxUmxhNmx1d1YwTkhOdTRPcWZ0VStmcWhodFgyb252eDVXdXpCbWd0SlBDcExyeHhtOXBOcHhWclRJaUdoSU9tak5KUQpmNlFTWlJqNHZXRG96VmdDVzF4QWtST0dYbW5hQndBQUFBTUJBQUVBQUFHQUEyWGVjUW1xYU50Wmh3L1FKRG91UEJWT3pvCkwwWWVYTitEWUVxQmFKZDBIMzF4elowNHpsVmlyUzFvVFVHWXBQcGtnWEUrd05DdFpDWXRlTVVqZ3N0N3BPRjNKNnJnVFAKUWRZRFIweEI2dUV6Zm5HYWRpaW1LQ0txT0ZwNWF2NDRFMkJmbEZtY1hxZHBkOEZ5T1lCb1dyMmVzY2RqekM2M1FKRGs5NgpHNEdGYnUwR3RIaE1QbmFWQlFFMndzeUJRTzYrbk1kNXpsMjVHeFUvY2V0Wm0zNThkQlF3ZGkrRG9FTzEvTE1LZmw4THVTCjExUzNJWmNkUUFQa3JQY25Hd3NTTWhlcXB1L2FKT1NWOEtkR3pCendWelkrZjN0WldET2w0d1BDUHE0dnJUMGdwSUFzeHYKRE5IWUh4Q25OSEZ0clE0UGVNUFkwR1hOUDh5dWJwM3dEem9ma2JuM2FqbTBtZm5zUjVIbWNxU2c4cWd1OUFYSmlQaHBDNgpha2duNzloTGZ5RXhjOHdQelFOM2FSUTB2cWdtZHR3OVZEc3Z3Njl3NU1td1dzK3FNcjJWVnJpNXo3SmJ0ckl3c1d4QVVjCkM3eForMnk0VEQwU0s0STR2V0VYZHNuRzNmMitiVzNIYTZDQ3Y4bll3RmRMVThtTGxBYTFVbm1xU24zcjJSeVV4UkFBQUEKd0gxZlFvWHBoNGdZK1hjbmxnVlVWczVFWEJ6cHNCYXBNWkd1R3J2K3ZVQk9Gc2pwdmE0VmJDZkZPTjBFRU4weG55VTF3Twpmc0NmVXZ1REZvL2RFUitNWG9UYnlOQm9SQ3kzZENQOXpwc1ZzdW5ZYkNqa21SekJIQVRwT3dXWU5sQk9ncGRpZEdEZ2tDCk9ucEVTdVROTjkySTQzV0RENFpGTWdJOG5xUXVCL1gycndSZkVLaHFEakxuWFdqSzNBd0JCMDlVYXJDS2diRjNwZXIrWkQKV1hnK0JEOEowL2xXbWIySm83ekpnLzlwNG1ZM3ZhUDNkNGJxTndydGV2dWdEVkRnQUFBTUVBK3BXQW9DVTgwbU1CSkVGcQp2N3psczNxN0V3bngwUytlY3BENm1uYTFrOGt6M1VsQWMxd2RoY2w3allvbEhBbmQxMTFaLzZPYWdxZUt4VGVQaG9uaGZhCmxDVGwyZXB5V3JyNjZxbkxUUStVOVFQZDJ2K0NxV295RTR3Wlg5UWthRTRjeXo2VWNmUVhneUFsNFgrK3lwbDBJUnBsRHQKOUcveGNscTVBR0s4ZENWaERKSis4ZlE5clczeDhlQ1RnM2RRYTRic0Yrc0FsT3lpMmNSd1VJTk1iWHI4ZUp5dEk2V2tGZApqMCswcjU4N2lSenlnVFFSbk9IYzdmY2JJb2wrVFpBQUFBd1FEU3hKb2lObWV5TFM1TzNQY1dxOEZXZk1YSTBoeVd0ZWFDCnl1cFp5WHNkODZwVWhZSlAyVC9MUWlZRlhiejVBQmJlRFhhWTBwNnV4TC9xOWUvdXYrMTZ1RXdHK0hJSk14U3RPbDUwNG4KVDJDNTF0QkZwR0xWK2ZzZ2FtREw1dFJSQW02L0JRaHlvem02TzBZNFNDNzc2RjFab1BzUkdLeVp4ckpMcjhWZ3V6UHRpYgphUGt0ckFLdUxjd1p5MTB3R3luRFY0QU5HZ2RCOHBwdW5LamhuYWN6a0QwTUFDVGJlZndjL1g5aXdnN1BDcVBlNm9lVGhlCmVPN000WDRkZFE2ZDhBQUFBWWRXSjFiblIxUUcxamFHVnlibWxoZG5OcmFYa3RkbTB4QVFJRAotLS0tLUVORCBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0K
kind: Secret
metadata:
  name: remote-ssh-key
  namespace: k0rdent-ssh
  labels:
    k0rdent.mirantis.com/component: "kcm"
type: Opaque
  EOF

cat > remote-cred.yaml << EOF
apiVersion: k0rdent.mirantis.com/v1beta1
kind: Credential
metadata:
  name: k0rdent-ssh-cred
  namespace: k0rdent-ssh
spec:
  identityRef:
    apiVersion: v1
    kind: Secret
    name: remote-ssh-key
    namespace: k0rdent-ssh
  EOF

cat > remote-ssh-key-resource-template.yaml << EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: remote-ssh-key-resource-template
  namespace: k0rdent-ssh
  labels:
    k0rdent.mirantis.com/component: "kcm"
  annotations:
    projectsveltos.io/template: "true"
EOF

cat > my-remote-clusterdeployment1.yaml << EOF
apiVersion: k0rdent.mirantis.com/v1beta1
kind: ClusterDeployment
metadata:
  name: k0rdent-ssh-clusterdeployment1
  namespace: k0rdent-ssh
spec:
  template: custom-remote-cluster-0-2-0 # name of the clustertemplate
  credential: k0rdent-ssh-cred
  propagateCredentials: false
  dryRun: false
  config:
    clusterLabels:
      custom-lb: demo-k0rdent-ssh-lb
    clusterAnnotations:
      custom-ant: demo-k0rdent-ssh-ant
    k0smotron:
      service:
        type: NodePort
    machines:
      - address: 10.224.158.116
        user: root # The user must have root permissions 
        port: 22
EOF

---

cat > ct-helm.yaml << EOF
apiVersion: source.toolkit.fluxcd.io/v1
kind: HelmRepository
metadata:
  labels:
    k0rdent.mirantis.com/managed: "true"
  name: kozmod-oot-repo
  #  namespace: kcm-system
  namespace: k0rdent-ssh
spec:
  interval: 10m0s
  provider: generic
  type: oci
  url: oci://ghcr.io/kozmod/helm-charts
status: {}

---
apiVersion: k0rdent.mirantis.com/v1beta1
kind: ClusterTemplate
metadata:
  name: custom-remote-cluster-0-2-0
  #  namespace: kcm-system
  namespace: k0rdent-ssh
  annotations:
    helm.sh/resource-policy: keep
spec:
  helm:
    chartSpec:
      chart: custom-remote-cluster
      version: 0.2.0
      interval: 10m0s
      sourceRef:
        kind: HelmRepository
        name: kozmod-oot-repo
EOF

  kubectl apply -f ct-helm.yaml
  kubectl apply -f remote-ssh-key-secret.yaml -f remote-cred.yaml -f remote-ssh-key-resource-template.yaml
  kubectl apply -f my-remote-clusterdeployment1.yaml


  kubectl delete -f my-remote-clusterdeployment1.yaml
  kubectl delete -f ct-helm.yaml
  kubectl delete -f remote-ssh-key-resource-template.yaml -f remote-cred.yaml -f remote-ssh-key-secret.yaml
```