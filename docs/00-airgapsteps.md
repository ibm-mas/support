# airgap steps 

## Introcution
The aim of this document is to present an installation of MAS in an airgapped environment, an environment that has no or limited connection to the Internet.

in such environment, conatainer images are served by a private image registry. Therefore, before the install can take place, you have to prepare a private image registry, then mirror the images that will bee needed to run OCP and for the installation MAS and applications and its dependencies.

## setup image registry

for setting up the image registry you have to consider the disk space required to host all the images.
to get an idea of how much storage is required, you can refer to:
https://ibm-mas.github.io/cli/guides/image-mirroring/#storage-requirements
https://ibm-mas.github.io/cli/commands/mirror-redhat-images/#storage-requirements



### on a vm
        
### on openshift 

## mas configure-ocp-for-mirror

## mirror images

## simulate airgap (only for mas images)

## install mas

