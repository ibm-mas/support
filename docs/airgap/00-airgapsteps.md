# Installing MAS in an Airgap environment

## Introduction

The aim of this document is to present an installation of MAS in an airgapped environment, an environment that has no or limited connection to the Internet.

In such environment, container images are served by a private image registry. Therefore, before the install can take place, you have to prepare a private image registry, then mirror the images that will bee needed to run OCP and for the installation MAS and applications and its dependencies.

## Setup image registry

For setting up the image registry you have to consider the disk space required to host all the images.  
to get an idea of how much storage is required, you can refer to:  
[https://ibm-mas.github.io/cli/guides/image-mirroring/#storage-requirements](https://ibm-mas.github.io/cli/guides/image-mirroring/#storage-requirements)  
[https://ibm-mas.github.io/cli/commands/mirror-redhat-images/#storage-requirements](https://ibm-mas.github.io/cli/commands/mirror-redhat-images/#storage-requirements)  


## Overview


1. setup image registry
2. miror images
3. configure OCP
4. install MAS

The MAS cli has commands to execute those steps, it can be run interactively or not.


