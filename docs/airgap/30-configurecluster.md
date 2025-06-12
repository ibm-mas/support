# configure cluster

login to the bastion node and run

==
yum install -y git
git clone https://github.com/rook/rook.git
cd rook/deploy/examples
oc apply -f common.yaml
oc apply -f operator-openshift.yaml
oc apply -f crds.yaml
oc apply -f cluster.yaml
oc apply -f ./csi/rbd/storageclass.yaml
oc apply -f ./csi/rbd/pvc.yaml
oc apply -f filesystem.yaml
oc apply -f ./csi/cephfs/storageclass.yaml
oc apply -f ./csi/cephfs/pvc.yaml
oc apply -f toolbox.yaml
# set rook-cephfs as default class
oc patch storageclass rook-cephfs -p '{"metadata": {"annotations": {"storageclass.kubernetes.io/is-default-class": "true"}}}'
==

