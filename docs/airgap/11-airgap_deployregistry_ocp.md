# Deploy registry to OCP

## Use the mas cli to create the registry

you can use the mas cli ```setup-registry``` to deploy an image registry in your OCP cluster.  
the advantage is that it is simple to deploy the image registry, the iconvenient is that if you cluster is discarded, you loose your images and you will have to mirror all the images again when you make a new airgap install.  
  
```
[ibmmas/cli:4.1.3]mascli$ mas setup-registry
IBM Maximo Application Suite Air Gap Registry Setup
Powered by https://github.com/ibm-mas/ansible-devops/

Current Limitations
1. This is still a work in progress


1. Set Target OpenShift Cluster
Connected to OCP cluster: 
   https://console-openshift-console.apps.siccing.cp.fyre.ibm.com
Proceed with this cluster? [Y/n] y

2. Configure Installation
Registry Namespace > airgap-registry
Registry Storage Class > rook-cephfs
Registry Storage Capacity > 300Gi
Registry Service Type > loadbalancer

3. Configure Authentication
Mirror Registry Username > admin
Mirror Registry Password > redhat
Proceed with these settings [y/N] y





        "Registry Hostname ...................... apps.siccing.cp.fyre.ibm.com",
        "registry Port .......................... 32500",
        "Registry Username ...................... admin",
        "Registry Password ...................... redhat",
        "Registry CA certificate ................ /tmp/apps.siccing.cp.fyre.ibm.com:32500/ca.crt",
        "  Install the certificate:",
        "  mv \"/tmp/apps.siccing.cp.fyre.ibm.com:32500\" \"/etc/docker/certs.d/apps.siccing.cp.fyre.ibm.com:32500\"",
        "Login Command .......................... docker login apps.siccing.cp.fyre.ibm.com:32500"
```

in later step, you will need the ca certificate of the registry, you can obtain it from the airgap-registry-ca secret:  

```
oc extract secret/airgap-registry-ca -n airgap-registry
```






## create route for registry:

create a yaml file:
```
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: registry
  namespace: airgap-registry
spec:
  host: registry.apps.siccing.cp.fyre.ibm.com
  port:
    targetPort: 5000
  tls:
    termination: passthrough
  to:
    kind: Service
    name: airgap-registry-lb
    weight: 100
  wildcardPolicy: None
```
use oc to create the route:  
```oc create -f registry-route.yaml```


## References
[https://github.com/ibm-mas/ansible-devops/tree/master/ibm/mas_devops/roles/registry](https://github.com/ibm-mas/ansible-devops/tree/master/ibm/mas_devops/roles/registry)  
[https://ibm-mas.github.io/cli/commands/setup-registry/](https://ibm-mas.github.io/cli/commands/setup-registry/)  
[https://github.com/ibm-mas/cli/blob/master/image/cli/mascli/functions/setup_registry](https://github.com/ibm-mas/cli/blob/master/image/cli/mascli/functions/setup_registry)