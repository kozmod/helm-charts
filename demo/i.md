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

helm show chart oci://ghcr.io/kozmod/helm-charts/kubevirt-custom-crd --version 0.1.0

```yaml
cat > ct-helm.yaml << EOF
---
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
  name: kubevirt-custom-crd-0-1-0
#  namespace: kcm-system
  namespace: k0rdent-ssh
  annotations:
    helm.sh/resource-policy: keep
spec:
  helm:
    chartSpec:
      chart: kubevirt-custom-crd
      version: 0.1.0
      interval: 10m0s
      sourceRef:
        kind: HelmRepository
        name: kozmod-oot-repo
EOF

kubectl apply -f ct-helm.yaml
kubectl delete -f ct-helm.yaml
```