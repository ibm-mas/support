# mas install in airgap environment

mascli$ mas install
IBM Maximo Application Suite Installer
Powered by https://github.com/ibm-mas/ansible-devops/ and https://tekton.dev/

Current Limitations
1. Support for airgap installation is limited to Core with IoT, Manage, Optimizer at present


1. Set Target OpenShift Cluster
Connected to OCP cluster: 
   https://console-openshift-console.apps.siccing.cp.fyre.ibm.com
Proceed with this cluster? [Y/n] y

2. Install OpenShift Pipelines Operator
OpenShift Pipelines Operator is installed and ready

3. Configure Installation
MAS Instance ID > ag 
MAS Workspace ID > agws            
MAS Workspace Display Name > airgap workspace
MAS Version:
April 14 2023 Update
  1. 8.10.0
  2. 8.9.4
March 14 2023 Update
  3. 8.9.3
February 17 2023 Update
  4. 8.9.2
January 11 2023 Update
  5. 8.9.1
Select Catalog Source > 1

3.1. License Terms
 For information about your license, see https://ibm.biz/MAS810-License  To continue with the installation, you must accept the license terms.
Do you accept the license terms? [y/N] y

4. Configure Operation Mode
Maximo Application Suite can be installed in a non-production mode for internal development and testing, this setting cannot be changed after installation:
 - All applications, add-ons, and solutions have 0 (zero) installation AppPoints in non-production installations.
 - These specifications are also visible in the metrics that are shared with IBM® and on the product UI.

Use non-production mode? [y/N] y

5. Configure Domain & Certificate Management
Configure Custom Domain [y/N] n

6. Application Selection
Install IoT [y/N] n
Install Manage [y/N] n
Install Optimizer [y/N] n
Install Visual Inspection [y/N] 

7. Configure Db2
The installer can setup one or more IBM Db2 instances in your OpenShift cluster for the use of applications that require a JDBC datasource (IoT, Manage, Monitor, & Predict) or you may choose to configure MAS to use an existing database.

No applications have been selected that require a Db2 installation

8. Additional Configuration
Additional resource definitions can be applied to the OpenShift Cluster during the MAS configuration step.
The primary purpose of this is to apply configuration for Maximo Application Suite itself, but you can use this to deploy ANY additional resource into your cluster.

Use additional configurations? [y/N] n

9. Configure Storage Class Usage
Maximo Application Suite and it's dependencies require storage classes that support ReadWriteOnce (RWO) and ReadWriteMany (RWX) access modes:
  - ReadWriteOnce volumes can be mounted as read-write by multiple pods on a single node.
  - ReadWriteMany volumes can be mounted as read-write by multiple pods across many nodes.


Select the ReadWriteOnce and ReadWriteMany storage classes to use from the list below:
 - rook-ceph-block
 - rook-cephfs

Enter 'none' for the ReadWriteMany storage class if you do not have a suitable class available in the cluster, however this will limit what can be installed

ReadWriteOnce (RWO) storage class > rook-ceph-block
ReadWriteMany (RWX) storage class > rook-cephfs

10. Advanced Settings
Configure Advanced Settings (optional)? [y/N] n

11. Configure IBM Container Registry
IBM Entitlement Key >  ********************************************************************************************************************************************************************************

12. Configure Product License
License ID > 10005ae0addd
License File > /images/license.dat

13. Configure UDS
UDS Contact Email > matthieulrx@nl.ibm.com
UDS Contact First Name > Matthieu
UDS Contact Last Name > Leroux

14. Prepare Installation
If you are using using storage classes that utilize 'WaitForFirstConsumer' binding mode choose 'No' at the prompt below

Wait for PVCs to bind? [Y/n] n

Preparing namespace 'mas-ag-pipelines' ...Override image tag '4.1.3' with digest? [Y/n] y
Using image digest sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
Namespace 'mas-ag-pipelines' is ready

Installed Task Definitions
mas-devops-appconnect                   quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-cert-manager                 quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-cluster-monitoring           quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-common-services              quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-cos                          quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-cp4d                         quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-cp4d-service                 quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-db2                          quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-gencfg-workspace             quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-ibm-catalogs                 quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-kafka                        quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-mongodb                      quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-must-gather                  quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-nvidia-gpu                   quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-sls                          quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-app-config             quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-app-install            quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-app-upgrade            quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-config                 quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-db2-setup-for-manage   quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-dns                    quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-install                quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-uninstall              quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-upgrade                quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-suite-verify                 quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010
mas-devops-uds                          quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010

Installed Pipeline Definitions
NAME            AGE
mas-db2         1s
mas-install     1s
mas-uninstall   1s
mas-update      1s
mas-upgrade     1s

quay.io/ibmmas/cli@sha256:c9c1acc54488c755effa627a0ca9e26db5652ec009c226e6aad421b63d556010 is available from the target OCP cluster

15. Review Settings

    IBM Maximo Application Suite
    Instance ID ............... ag
    Workspace ID .............. agws
    Workspace Name ............ airgap workspace
    Operation Mode ............ Non-production
    Catalog Source ............ ibm-operator-catalog
    Subscription Channel ...... 8.10.x
    IBM Entitled Registry ..... cp.icr.io/cp
    IBM Open Registry ......... icr.io/cpopen
    Entitlement Username ...... cp
    Entitlement Key ........... eyJhbGci<snip>

    IBM Maximo Application Suite Applications
    IoT ...................... Skip Installation
     - Monitor ............... Skip Installation
    Manage ................... Skip Installation
     - Predict ............... Skip Installation
    Assist ................... Skip Installation
    MVI ...................... Skip Installation

    IBM Suite License Service
    Catalog Source ............ ibm-operator-catalog
    License ID ................ 10005ae0addd
    License File .............. /workspace/entitlement/license.dat
    IBM Entitled Registry ..... cp.icr.io/cp
    IBM Open Registry ......... icr.io/cpopen
    Entitlement Username ...... cp
    Entitlement Key ........... eyJhbGci<snip>

    IBM User Data Services
    Contact Email ............. matthieulrx@nl.ibm.com
    First Name ................ Matthieu
    Last Name ................. Leroux

    Storage Class Configuration
    Storage Class Provider ... custom
    ReadWriteOnce ............ rook-ceph-block
    ReadWriteMany ............ rook-cephfs

Proceed with these settings [y/N] y

16. Launch Installation
Installation started successfully

View progress:
  https://console-openshift-console.apps.siccing.cp.fyre.ibm.com/pipelines/ns/mas-ag-pipelines





troubleshooting

if the mirror command fails with permission error, make sure the volumes are mounted with :z option
you may also need to allow access policy 
You can generate a local policy module to allow this access.
Allow this access for now by executing:
# ausearch -c 'python3' --raw | audit2allow -M my-python3
# semodule -X 300 -i my-python3.pp


======




issue: the pipeline start but fails almost straight away on pre-install-check, no logs are available, the corresponding pod no longer exists.

rerun the pipeline and go to workload>pods
you see the pod is created but in imagepullbackoff error,
get the event before the pod is terminated:

Failed to pull image "quay.io/ibmmas/cli:13.13.0": (Mirrors also failed: [ml-registry1.fyre.ibm.com:5000/ibmmas/cli:13.13.0: reading manifest 13.13.0 in ml-registry1.fyre.ibm.com:5000/ibmmas/cli: manifest unknown]): quay.io/ibmmas/cli:13.13.0: registry quay.io/ibmmas is blocked in /etc/containers/registries.conf or /root/.config/containers/registries.conf.d


mas install command should detect that it is an airgap install and use digest instead.

check the mas.log file in the mas cli container

2025-03-26 13:37:48,718   DEBUG    >>> BaseApp.createTektonFileWithDigest
2025-03-26 13:37:48,719   DEBUG    We have already generated /opt/app-root/lib64/python3.9/site-packages/mas/cli/templates/ibm-mas-tekton-with-digest.yaml
2025-03-26 13:37:48,719   DEBUG    <<< BaseApp.createTektonFileWithDigest

apply the yaml file:
oc project mas-test-pipelines
oc apply -f /opt/app-root/lib64/python3.9/site-packages/mas/cli/templates/ibm-mas-tekton-with-digest.yaml

rerun the pipeline

PodPtest-install-250326-1339-f0og95-pre-install-check-pod
NamespaceNSmas-test-pipelines
Mar 26, 2025, 2:53 PM
Generated from kubelet on worker0.ml-ag.cp.fyre.ibm.com
Failed to pull image "quay.io/ibmmas/cli@sha256:9f6c745235d7da2eb56f5b193927789f2b3c433d1fcbbabaeed5e28584ee871e": (Mirrors also failed: [ml-registry1.fyre.ibm.com:5000/ibmmas/cli@sha256:9f6c745235d7da2eb56f5b193927789f2b3c433d1fcbbabaeed5e28584ee871e: reading manifest sha256:9f6c745235d7da2eb56f5b193927789f2b3c433d1fcbbabaeed5e28584ee871e in ml-registry1.fyre.ibm.com:5000/ibmmas/cli: manifest unknown]): quay.io/ibmmas/cli@sha256:9f6c745235d7da2eb56f5b193927789f2b3c433d1fcbbabaeed5e28584ee871e: registry quay.io/ibmmas is blocked in /etc/containers/registries.conf or /root/.config/containers/registries.conf.d


add the image to the registry:
skopeo copy docker://quay.io/ibmmas/cli@sha256:9f6c745235d7da2eb56f5b193927789f2b3c433d1fcbbabaeed5e28584ee871e docker://ml-registry1.fyre.ibm.com:5000/ibmmas/cli@sha256:9f6c745235d7da2eb56f5b193927789f2b3c433d1fcbbabaeed5e28584ee871e

gives error about invalid manifest

instead,
skopeo copy docker://quay.io/ibmmas/cli13.13.0 docker://ml-registry1.fyre.ibm.com:5000/ibmmas/cli:13.13.0

then get the digest:
cat /images/data/docker/registry/v2/repositories/ibmmas/cli/_manifests/tags/13.13.0/current/link
sha256:8ba9cf2e0f2533530d74f9359ad06c97083a4540093f17c021493bdcf897225d

replace the reference in /opt/app-root/lib64/python3.9/site-packages/mas/cli/templates/ibm-mas-tekton-with-digest.yaml
vi /opt/app-root/lib64/python3.9/site-packages/mas/cli/templates/ibm-mas-tekton-with-digest.yaml

use:
:%s/9f6c745235d7da2eb56f5b193927789f2b3c433d1fcbbabaeed5e28584ee871e/8ba9cf2e0f2533530d74f9359ad06c97083a4540093f17c021493bdcf897225d

to replace all occurence.
then apply the file again
oc project mas-test-pipelines
oc apply -f /opt/app-root/lib64/python3.9/site-packages/mas/cli/templates/ibm-mas-tekton-with-digest.yaml


## Troubleshooting



## References
