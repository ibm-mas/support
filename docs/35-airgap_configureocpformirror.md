# Configure ocp for mirror

## Steps


```
export SETUP_REDHAT_RELEASE=true
export SETUP_REDHAT_CATALOGS=true
mas configure-airgap -H ml-registry1.fyre.ibm.com -P 5000 -c /images/certs/server.crt -u admin -p redhat --no-confirm
```


## Troubleshooting

### ImageDigestMirrorSet
The above command will execute:  
https://github.com/ibm-mas/cli/blob/master/image/cli/mascli/functions/configure_airgap  
that will call the following ansible role:  
https://github.com/ibm-mas/ansible-devops/tree/master/ibm/mas_devops/roles/ocp_idms  
as a result, that will create an imageDigestMirrorSet.  
An ImageDigestMirrorSet (IDMS) in OpenShift is a custom resource (CR) used to configure image mirroring based on image digests, allowing you to pull images from a mirrored registry when the image digest matches a configured rule.
```
oc get idms
oc get idms -oyaml
```

if not there, when pulling an image from the external registry, OCP would not know where to get it and you would have an imagepull error.  
  
NOTE: idms and itms were introduced in ocp 4.14.  
before that it was icsp (imagecontentsourcepolicy)

```
oc get imagecontentsourcepolicies
NAME                       AGE
ibm-mas-and-dependencies   3m28s

oc get imagecontentsourcepolicies -o yaml
extract from the yaml:
  spec:
    repositoryDigestMirrors:
    - mirrors:
      - image-registry1.fyre.ibm.com:5000/cpopen
      source: icr.io/cpopen
    - mirrors:
      - image-registry1.fyre.ibm.com:5000/ibm-truststore-mgr
      source: icr.io/ibm-truststore-mgr
```

### Certificate

when the command is executed, a configmap is created in the openshift-config namespace to contain the image registry CA certificate.
this secret is referenced in the image.config.openshift.io
oc get image.config.openshift.io cluster -oyaml

for more information:
- https://github.com/ibm-mas/ansible-devops/blob/master/ibm/mas_devops/roles/ocp_idms/tasks/trust.yml
- https://access.redhat.com/solutions/6969479

this is the certificate that was created when the registry was created, if it has expired, you will need to update this configmap

### machineConfig

when the idms is created, the config will be applied to each node through a machine config  
if a failure occurs, you may see something like:  
```
TASK [ibm.mas_devops.ocp_idms : Wait for node pools to finish updating] ************************************************************************
FAILED - RETRYING: [localhost]: Wait for node pools to finish updating (30 retries left).
```

To troubleshoot, you can open the machine config (sort by created descending)  
search in the yaml for:  
```
        - contents:
            compression: ''
            source: 'data:text/plain;charset=utf-8;base64,dW5xdWFsaWZpZWQtc2VhcmNoLXJlZ2lzdHJpZXMgPSBbInJlZ2lzdHJ5LmFjY2Vzcy5yZWRoYXQuY29tIiwgImRvY2tlci5pbyJdCnNob3J0LW5hbWUtbW9kZSA9ICIiCgpbW3JlZ2lzdHJ5XV0KICBwcmVmaXggPSAiIgogIGxvY2F0aW9uID0gImNwLmljci5pby9jcCIKICBibG9ja2VkID0gdHJ1ZQoKICBbW3JlZ2lzdHJ5Lm1pcnJvcl1dCiAgICBsb2NhdGlvbiA9ICJtbC1yZWdpc3RyeTEuZnlyZS5pYm0uY29tOjUwMDAvY3AiCiAgICBwdWxsLWZyb20tbWlycm9yID0gImRpZ2VzdC1vbmx5IgoKW1tyZWdpc3R[...]
            m1pcnJvcl1dCiAgICBsb2NhdGlvbiA9ICJtbC1yZWdpc3RyeTEuZnlyZS5pYm0uY29tOjUwMDAvdWJpOCIKICAgIHB1bGwtZnJvbS1taXJyb3IgPSAiZGlnZXN0LW9ubHkiCgpbW3JlZ2lzdHJ5XV0KICBwcmVmaXggPSAiIgogIGxvY2F0aW9uID0gInJlZ2lzdHJ5LnJlZGhhdC5pby91Ymk5IgogIGJsb2NrZWQgPSB0cnVlCgogIFtbcmVnaXN0cnkubWlycm9yXV0KICAgIGxvY2F0aW9uID0gIm1sLXJlZ2lzdHJ5MS5meXJlLmlibS5jb206NTAwMC91Ymk5IgogICAgcHVsbC1mcm9tLW1pcnJvciA9ICJkaWdlc3Qtb25seSIK'
          mode: 420
          overwrite: true
          path: /etc/containers/registries.conf
```
the string is base 64 encoded, you can decode it to view the content:  
```
echo "dW5xdWFsaWZpZWQtc2VhcmNoLXJlZ2lzdHJpZXMgPSBbInJlZ2lzdHJ5LmFjY2Vzcy5yZWRoYXQuY29tIiwgImRvY2tlci5pbyJdCnNob3J0LW5hbWUtbW9kZSA9ICIiCgpbW3JlZ2lzdHJ5XV0KICBwcmVmaXggPSAiIgogIGxvY2F0aW9uID0gImNwLmljci5pby9jcCIKICBibG9ja2VkID0gdHJ1ZQoKICBbW3JlZ2lzdHJ5Lm1pcnJvcl1dCiAgICBsb2NhdGlvbiA9ICJtbC1yZWdpc3RyeTEuZnlyZS5pYm0uY29tOjUwMDAvY3AiCiAgICBwdWxsLWZyb20tbWlycm9yID0gImRpZ2VzdC1vbmx5IgoKW1tyZWdpc3R[...]            m1pcnJvcl1dCiAgICBsb2NhdGlvbiA9ICJtbC1yZWdpc3RyeTEuZnlyZS5pYm0uY29tOjUwMDAvdWJpOCIKICAgIHB1bGwtZnJvbS1taXJyb3IgPSAiZGlnZXN0LW9ubHkiCgpbW3JlZ2lzdHJ5XV0KICBwcmVmaXggPSAiIgogIGxvY2F0aW9uID0gInJlZ2lzdHJ5LnJlZGhhdC5pby91Ymk5IgogIGJsb2NrZWQgPSB0cnVlCgogIFtbcmVnaXN0cnkubWlycm9yXV0KICAgIGxvY2F0aW9uID0gIm1sLXJlZ2lzdHJ5MS5meXJlLmlibS5jb206NTAwMC91Ymk5IgogICAgcHVsbC1mcm9tLW1pcnJvciA9ICJkaWdlc3Qtb25seSIK" | base64 -d
```

you can check the mahine config pool to see what is machine config was applied:
```
oc get mcp
NAME     CONFIG                                             UPDATED   UPDATING   DEGRADED   MACHINECOUNT   READYMACHINECOUNT   UPDATEDMACHINECOUNT   DEGRADEDMACHINECOUNT   AGE
master   rendered-master-5c62e30608f8b465e90185efde5f0baa   True      False      False      3              3                   3                     0                      105m
worker   rendered-worker-56d4a60c79317f246280a1583ee116e3   True      False      False      3              3                   3                     0                      105m
```
## References

https://docs.redhat.com/en/documentation/openshift_container_platform/4.16/html/config_apis/imagedigestmirrorset-config-openshift-io-v1  
https://github.com/ibm-mas/ansible-devops/blob/master/ibm/mas_devops/roles/ocp_idms/tasks/trust.yml  
https://access.redhat.com/solutions/6969479  
https://github.com/ibm-mas/cli/blob/master/image/cli/mascli/functions/configure_mirror  
https://github.com/ibm-mas/ansible-devops/tree/master/ibm/mas_devops/roles/ocp_idms  