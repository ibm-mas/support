# Simulate airgap

## Get the registry certificate

if you deployed the registry in OCP:  
```
oc extract secret/airgap-registry-ca -n airgap-registry
export REGISTRY_PRIVATE_CA_FILE=ca.crt 
```
  
if yo udeployed the registry in a VM:  
```
export REGISTRY_PRIVATE_CA_FILE=/mnt/home/domain.crt
export REGISTRY_PRIVATE_CA_FILE=/images/certs/ca.crt
```

## Remove connectivity to the external registies

to simulate airgap, we remove connectivity to the external registries. To do so, we create a fake entry in the host file of the nodes for the various registries.  
```
mascli$ ansible localhost -m include_role -a name=ansible-devops/roles/ocp_simulate_disconnected_network
```

Alternatively, you can use the playbook ocp_convert_to_disconnected, that will execute the following 3 roles:  
    - ibm.mas_devops.ocp_config
    - ibm.mas_devops.ocp_idms
    - ibm.mas_devops.ocp_simulate_disconnected_network

```
export REGISTRY_PRIVATE_HOST=mlregistry1.fyre.ibm.com
export REGISTRY_PRIVATE_PORT=5000
export REGISTRY_PRIVATE_CA_FILE=/images/certs/domain.crt
export REGISTRY_USERNAME=admin
export REGISTRY_PASSWORD=redhat

ansible-playbook ansible-devops/playbooks/ocp_convert_to_disconnected.yml
```
## Troubleshooting

### verify the host file on the host
when the role is executed, a machine config is created and applied to all the nodes.  
you can check the host file on the node, for example:  
```
[root@api.mas-ml-airgap.cp.fyre.ibm.com ~]# ssh core@worker1 'cat /etc/hosts'
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
1.2.3.4     quay.io registry.redhat.io registry.connect.redhat.com gcr.io nvcr.io icr.io cp.icr.io docker-na-public.artifactory.swg-devops.com
172.30.210.198 image-registry.openshift-image-registry.svc image-registry.openshift-image-registry.svc.cluster.local # openshift-generated-node-resolver
```

### verify the machine config

in the list of machine config, you can look for the last applie config and search the yaml for the hosts file, then you can use base64 to view the data:  
```
matthieu:~$ echo "MTI3LjAuMC4xICAgbG9jYWxob3N0IGxvY2FsaG9zdC5sb2NhbGRvbWFpbiBsb2NhbGhvc3Q0IGxvY2FsaG9zdDQubG9jYWxkb21haW40Cjo6MSAgICAgICAgIGxvY2FsaG9zdCBsb2NhbGhvc3QubG9jYWxkb21haW4gbG9jYWxob3N0NiBsb2NhbGhvc3Q2LmxvY2FsZG9tYWluNgoxLjIuMy40ICAgICBxdWF5LmlvIHJlZ2lzdHJ5LnJlZGhhdC5pbyByZWdpc3RyeS5jb25uZWN0LnJlZGhhdC5jb20gZ2NyLmlvIG52Y3IuaW8gaWNyLmlvIGNwLmljci5pbyBkb2NrZXItbmEtcHVibGljLmFydGlmYWN0b3J5LnN3Zy1kZXZvcHMuY29tIGRvY2tlci1uYS1wcm94eS1zdmwuYXJ0aWZhY3Rvcnkuc3dnLWRldm9wcy5jb20gZG9ja2VyLW5hLXByb3h5LXJ0cC5hcnRpZmFjdG9yeS5zd2ctZGV2b3BzLmNvbQoxNzIuMzAuMjMyLjE2IGltYWdlLXJlZ2lzdHJ5Lm9wZW5zaGlmdC1pbWFnZS1yZWdpc3RyeS5zdmMgaW1hZ2UtcmVnaXN0cnkub3BlbnNoaWZ0LWltYWdlLXJlZ2lzdHJ5LnN2Yy5jbHVzdGVyLmxvY2FsICMgb3BlbnNoaWZ0LWdlbmVyYXRlZC1ub2RlLXJlc29sdmVyCg==" | base64 -d
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
1.2.3.4     quay.io registry.redhat.io registry.connect.redhat.com gcr.io nvcr.io icr.io cp.icr.io docker-na-public.artifactory.swg-devops.com docker-na-proxy-svl.artifactory.swg-devops.com docker-na-proxy-rtp.artifactory.swg-devops.com
172.30.232.16 image-registry.openshift-image-registry.svc image-registry.openshift-image-registry.svc.cluster.local # openshift-generated-node-resolver
```

### Disable catalog
after the nodes are updated with the latest machine config, you may start seeing some pods in crashloopback, maybe you are missing some images in the registry or some configuration is incorrect (IDMS)  
  
when ocp_idms role was executed, 3 new catalogs were created:  
https://github.com/ibm-mas/ansible-devops/blob/master/ibm/mas_devops/roles/ocp_idms/templates/idms/mas-redhat-catalogs.yml.j2  
  
those use the private registry  
  
catalog sources that were present before may be in transient failure status  
  
you need to disable them, otherwise that will cause issue when installing operators  
 
```
oc get catalogsource -A
NAMESPACE               NAME                       DISPLAY               TYPE   PUBLISHER   AGE
openshift-marketplace   certified-operator-index   Certified Operators   grpc   Red Hat     38m
openshift-marketplace   certified-operators        Certified Operators   grpc   Red Hat     133m
openshift-marketplace   community-operator-index   Community Operators   grpc   Red Hat     38m
openshift-marketplace   community-operators        Community Operators   grpc   Red Hat     133m
openshift-marketplace   redhat-marketplace         Red Hat Marketplace   grpc   Red Hat     133m
openshift-marketplace   redhat-operator-index      Red Hat Operators     grpc   Red Hat     38m
openshift-marketplace   redhat-operators           Red Hat Operators     grpc   Red Hat     133m


oc patch operatorhubs/cluster --type merge --patch '{"spec":{"sources":[{"disabled": true,"name": "certified-operators"},{"disabled": true,"name": "community-operators"},{"disabled": true,"name": "redhat-marketplace"},{"disabled": true,"name": "redhat-operators"}]}}'
```

## References
https://github.com/ibm-mas/ansible-devops/tree/master/ibm/mas_devops/roles/ocp_simulate_disconnected_network  
https://github.com/ibm-mas/ansible-devops/blob/master/ibm/mas_devops/playbooks/ocp_convert_to_disconnected.yml
https://access.redhat.com/solutions/5611481  