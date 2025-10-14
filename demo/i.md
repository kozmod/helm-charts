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