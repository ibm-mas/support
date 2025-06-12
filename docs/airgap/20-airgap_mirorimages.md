# Mirror MAS and dependencies images

Use the mas cli to mirror the images:  
### Interactive mode

```  
[ibmmas/cli:13.16.0]mascli$ mas mirror-images
IBM Maximo Application Suite Air Gap Image Mirror (v13.16.0)
Powered by https://github.com/ibm-mas/ansible-devops/



1) Configure Catalog Version (see https://ibm-mas.github.io/cli/catalogs/ for details on catalogs)
MAS Catalog Version > v9-250306-amd64
MAS Channel > 9.0.X


2) Configure Mirror Mode
Working Directory > /images
Mirror Mode:
  1. Direct
  2. To filesystem
  3. From filesystem
Select Mirror Mode > 1


3) Configure Target Mirror
Mirror Registry Host > img-registry1.fyre.ibm.com
Mirror Registry Port > 5000
Mirror Registry Prefix > 


4) Configure Authentication
Mirror Registry Username > admin
Re-use saved registry password? [Y/n] 


5) Configure Images to Mirror
Mirror all MAS images (with dependencies) [y/N] 
IBM Maximo Operator Catalog [Y/n] 
IBM Maximo Application Suite - Core [Y/n] n
IBM Maximo Application Suite - Assist [y/N] 
IBM Maximo Application Suite - IoT [y/N] 
IBM Maximo Application Suite - Manage [y/N] 
IBM Maximo Application Suite - Monitor [y/N] 
IBM Maximo Application Suite - Optimizer [y/N] 
IBM Maximo Application Suite - Predict [y/N] 
IBM Maximo Application Suite - Visual Inspection [y/N] 
IBM Foundational Services [Y/n] n
IBM Suite License Service [Y/n] n
IBM Truststore Manager [Y/n] n
MongoDb Community Edition [Y/n] n
IBM Db2 [Y/n] n
IBM Cloud Pak for Data (CP4D) [y/N] n
IBM Watson Studio Local [y/N] 
IBM Watson Machine Learning [y/N] 
IBM Analytics Engine (Spark) [y/N] 
IBM Cognos Analytics [y/N] 
IBM AppConnect [y/N] 
Red Hat ODF [y/N] 


6) Configure Authentication
Re-use saved IBM Entitlement Key? [Y/n] 


7) Review Settings

    Settings
    Mirror Mode ......................... direct
    Working Directory ................... /images
    Target Registry ..................... img-registry1.fyre.ibm.com:5000

    IBM Operator Catalog
    Catalog Version ..................... v9-250306-amd64
    MAS Update Channel .................. 9.0.X

    Content Selection (Core Platform)
    IBM Maximo Operator Catalog ......... Mirror
    IBM Maximo Application Suite Core ... Skip

    Content Selection (Applications)
    IBM Maximo Assist ................... Skip
    IBM Maximo IoT ...................... Skip
    IBM Maximo Manage ................... Skip
    + IBM Maximo IT ..................... Skip
    IBM Maximo Monitor .................. Skip
    IBM Maximo Predict .................. Skip
    IBM Maximo Optimizer ................ Skip
    IBM Maximo Visual Inspection ........ Skip

    Content Selection (Cloud Pak for Data)
    IBM Cloud Pak for Data (CP4D) ....... Skip
    IBM Watson Studio ................... Skip
    IBM Watson Machine Learning ......... Skip
    IBM Analytics Engine (Spark)......... Skip
    IBM Cognos Analytics ................ Skip

    Content Selection (Other Dependencies)
    IBM Cloud Pak Foundation Services ... Skip
    IBM Suite License Service ........... Skip
    IBM Truststore Manager .............. Skip
    MongoDb Community Edition ........... Skip
    + Version 4 ......................... Skip
    + Version 5 ......................... Skip
    + Version 6 ......................... Skip
    + Version 7 ......................... Skip
    IBM Db2 ............................. Skip
    IBM AppConnect ...................... Skip
    RedHat ODF .......................... Skip

Proceed with these settings [y/N] y


8) Run Mirror Process
[SKIPPED] IBM Maximo Application Suite Core
[SKIPPED] IBM Maximo Assist
[SKIPPED] IBM Maximo IoT
[SKIPPED] IBM Maximo Manage
[SKIPPED] IBM Maximo Monitor
[SKIPPED] IBM Maximo Predict
[SKIPPED] IBM Maximo Optimizer
[SKIPPED] IBM Maximo Visual Inspection
[SUCCESS] Selected Dependencies: /images/logs/mirror-20250430-132211-dependencies.log
```

in the interactive command you have to provide the various options, like the catalog version, the subscription, the private registry details, the working folder, the mirror mode and authentication for the registry.

### Non-Interactive Mode

for the non-interactive options you can refer to the help:
```
[ibmmas/cli:13.24.0]mascli$ mas mirror-images -h
IBM Maximo Application Suite Air Gap Image Mirror (v13.24.0)
Powered by https://github.com/ibm-mas/ansible-devops/

Usage:
  mas mirror-images [options]
Where specified each option may also be defined by setting the appropriate environment variable.
When no options are specified on the command line, interactive-mode will be enabled by default.

Mirror Mode (Required):
  -m, --mode MIRROR_MODE                         Operation mode (direct, to-filesystem, from-filesystem)
  -d, --dir MIRROR_WORKING_DIR                   Working directory for the mirror process

Registry Details (Required):
  -H, --host REGISTRY_PUBLIC_HOST                 Hostname of the target registry
  -P, --port REGISTRY_PUBLIC_PORT                 Port number for the target registry
  -u, --username REGISTRY_USERNAME                Username to authenticate to the target registry
  -p, --password REGISTRY_PASSWORD                Password to authenticate to the target registry

Registry Prefix (Optional):
  -x, --prefix REGISTRY_PREFIX            Prefix for the mirror image

Source Registry Entitlements (Required based on what content you choose to mirror):
      --ibm-entitlement IBM_ENTITLEMENT_KEY       IBM Entitlement Key
      --artifactory-username ARTIFACTORY_USERNAME Artifactory Username
      --artifactory-token ARTIFACTORY_TOKEN       Artifactory Token

Maximo Operator Catalog Selection (Optional):
  -c, --catalog MAS_CATALOG_VERSION               Maximo Operator Catalog Version to mirror (e.g. v9-240625-amd64)
  -C, --channel MAS_CHANNEL                       Maximo Application Suite Channel to mirror (e.g. 9.0.x)

Content Selection (Core Platform):
      --mirror-catalog                            Mirror the IBM Maximo Operator Catalog
      --mirror-core                               Mirror images for IBM Maximo Application Suite Core

Content Selection (Applications):
      --mirror-assist                             Mirror images for IBM Maximo Assist
      --mirror-iot                                Mirror images for IBM Maximo IoT
      --mirror-manage                             Mirror images for IBM Maximo Manage
      --mirror-icd                                Mirror image  for IBM Maximo IT (Separately entitled IBM Maximo Manage extension)
      --mirror-monitor                            Mirror images for IBM Maximo Monitor
      --mirror-optimizer                          Mirror images for IBM Maximo Optimizer
      --mirror-predict                            Mirror images for IBM Maximo Predict
      --mirror-visualinspection                   Mirror images for IBM Maximo Visual Inspection

Content Selection (Cloud Pak for Data):
      --mirror-cp4d                               Mirror images for IBM Cloud Pak for Data Platform
      --mirror-wsl                                Mirror images for IBM Watson Studio Local
      --mirror-wml                                Mirror images for IBM Watson Machine Learning
      --mirror-spark                              Mirror images for IBM Analytics Engine (Spark)
      --mirror-cognos                             Mirror images for IBM Cognos Analytics

Content Selection (Other Dependencies):
      --mirror-cfs                                Mirror images for IBM Cloud Pak Foundation Services
      --mirror-sls                                Mirror images for IBM Suite License Service
      --mirror-tsm                                Mirror images for IBM Truststore Manager
      --mirror-mongo                              Mirror images for MongoDb Community Edition
      --mirror-mongo-v5                           Mirror images for MongoDb Community Edition version 5
      --mirror-mongo-v6                           Mirror images for MongoDb Community Edition version 6
      --mirror-mongo-v7                           Mirror images for MongoDb Community Edition version 7
      --mirror-db2                                Mirror images for IBM Db2
      --mirror-appconnect                         Mirror images for IBM AppConnect
      --mirror-odf                                Mirror images for ODF

Content Selection (All images included):
      --mirror-everything                         Mirror all MAS related images (including dependencies)

Other Commands:
      --no-confirm                                Mirror images without prompting for confirmation
  -h, --help                                      Show this help message
```

and to the following example: [https://ibm-mas.github.io/cli/examples/mirror-db2/](https://ibm-mas.github.io/cli/examples/mirror-db2/)

## Troubleshotting
if there are error, you can see them in the log file, you get the link at the end of the run.  
  
in the log file you see the details of the ansible playbook executed. In this example the playbook executed was mirror_core  
  
you can find more details about the command here:  
https://github.com/ibm-mas/cli/blob/master/image/cli/mascli/functions/mirror_images  
  
the playbook executed:  
https://github.com/ibm-mas/ansible-devops/blob/master/ibm/mas_devops/playbooks/mirror_dependencies.yml  
for the other playbooks, you can refer to the code for the mirror_images command, for example:  
```

  mirror_one_thing $MIRROR_MAS_CORE             "IBM Maximo Application Suite Core"     "$LOG_PREFIX-core.log"             mirror_core
  mirror_one_thing $MIRROR_MAS_ASSIST           "IBM Maximo Assist"                     "$LOG_PREFIX-assist.log"           mirror_add_assist
  mirror_one_thing $MIRROR_MAS_IOT              "IBM Maximo IoT"                        "$LOG_PREFIX-iot.log"              mirror_add_iot
  mirror_one_thing $MIRROR_MAS_MANAGE           "IBM Maximo Manage"                     "$LOG_PREFIX-manage.log"           mirror_add_manage
  mirror_one_thing $MIRROR_MAS_MONITOR          "IBM Maximo Monitor"                    "$LOG_PREFIX-monitor.log"          mirror_add_monitor
  mirror_one_thing $MIRROR_MAS_PREDICT          "IBM Maximo Predict"                    "$LOG_PREFIX-predict.log"          mirror_add_predict
  mirror_one_thing $MIRROR_MAS_OPTIMIZER        "IBM Maximo Optimizer"                  "$LOG_PREFIX-optimizer.log"        mirror_add_optimizer
  mirror_one_thing $MIRROR_MAS_VISUALINSPECTION "IBM Maximo Visual Inspection"          "$LOG_PREFIX-visualinspection.log" mirror_add_visualinspection
  mirror_one_thing $MIRROR_DEPS                 "Selected Dependencies"                 "$LOG_PREFIX-dependencies.log"     mirror_dependencies
```

### Details of mirrored images

in the working directory, you will also find a manifest folder, where you will have the details of the images to be mirrored, based on the mirror type, direct, to-filesystem, from-filesystem

### Verify the content of the registry:

verify content of catalog:  
curl https://registry.apps.siccing.cp.fyre.ibm.com:443/v2/_catalog -k -u admin  
  


### Errors

possible errors in the mirror logs:
    - 'error: unable to retrieve source image registry.redhat.io/rhel8/postgresql-12 manifest sha256:fa920188f567e51d75aacd723f0964026e42ac060fed392036e8d4b3c7a8129f: Get "https://registry.redhat.io/v2/rhel8/postgresql-12/manifests/sha256:fa920188f567e51d75aacd723f0964026e42ac060fed392036e8d4b3c7a8129f": unauthorized: Please login to the Red Hat Registry using your Customer Portal credentials. Further instructions can be found here: https://access.redhat.com/articles/3399531'
    - 'error: unable to retrieve source image registry.redhat.io/ubi8/nodejs-14 manifest sha256:881e871f845b9395f5e21cfa45f0d1838dc9af60c4f18ece67bd56a9e44846cc: Get "https://registry.redhat.io/v2/ubi8/nodejs-14/manifests/sha256:881e871f845b9395f5e21cfa45f0d1838dc9af60c4f18ece67bd56a9e44846cc": unauthorized: Please login to the Red Hat Registry using your Customer Portal credentials. Further instructions can be found here: https://access.redhat.com/articles/3399531'
    - 'error: an error occurred during planning'

check your credentials for the RedHat Registry and check that you are able to pull that image:
podman login registry.redhat.io
podman pull registry.redhat.io/rhel8/postgresql-12



    - 'error: unable to upload blob sha256:e74f44e4f683243a0446e47de088c9c8a1c55278bd3a0526e9e63c5f00000383 to image-registry1.fyre.ibm.com:5000/cp/mas/coreidp-login: received unexpected HTTP status: 500 Internal Server Error'
    - 'error: unable to upload blob sha256:f391635980289b620e6da853245581ec547fb5028be82822ae4046a7a301cf76 to image-registry1.fyre.ibm.com:5000/cp/mas/coreidp-login: received unexpected HTTP status: 500 Internal Server Error'
    - 'info: Mirroring completed in 1m37.83s (15.1MB/s)'
    - 'error: one or more errors occurred while uploading images'


### Manually mirror images


if you need to manually mirror some images, you can use skopeo copy, this command will preserve the digest where podman would change it.  
  
for example to manually copy the cli image to the image registry  
skopeo copy docker://quay.io/ibmmas/cli:13.13.0 docker://ml-registry1.fyre.ibm.com:5000/ibmmas/cli:13.13.0


## References

[https://github.com/ibm-mas/cli/blob/master/image/cli/mascli/functions/mirror_images](https://github.com/ibm-mas/cli/blob/master/image/cli/mascli/functions/mirror_images)  
Playbooks:  
[https://github.com/ibm-mas/ansible-devops/blob/master/ibm/mas_devops/playbooks/mirror_dependencies.yml](https://github.com/ibm-mas/ansible-devops/blob/master/ibm/mas_devops/playbooks/mirror_dependencies.yml)