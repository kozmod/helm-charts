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
  template: custom-remote-cluster-0-6-0 # name of the clustertemplate
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
  name: custom-remote-cluster-0-6-0
  #  namespace: kcm-system
  namespace: k0rdent-ssh
  annotations:
    helm.sh/resource-policy: keep
spec:
  helm:
    chartSpec:
      chart: custom-remote-cluster
      version: 0.6.0
      interval: 10m0s
      sourceRef:
        kind: HelmRepository
        name: kozmod-oot-repo
EOF

  kubectl apply -f remote-ssh-key-secret.yaml -f remote-cred.yaml -f remote-ssh-key-resource-template.yaml
  kubectl apply -f ct-helm.yaml
  kubectl apply -f my-remote-clusterdeployment1.yaml

  kubectl -n k0rdent-ssh get secret k0rdent-ssh-clusterdeployment1-kubeconfig -o jsonpath='{.data.value}' | base64 -d > child.conf


  kubectl delete -f my-remote-clusterdeployment1.yaml && \
  kubectl delete -f ct-helm.yaml
  kubectl delete -f remote-ssh-key-resource-template.yaml -f remote-cred.yaml -f remote-ssh-key-secret.yaml
```