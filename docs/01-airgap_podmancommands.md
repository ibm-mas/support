# usefull podman commands

list all containers:  
```
podman ps -a 
40e0838dfc67  quay.io/ibmmas/cli:latest          /bin/sh -c bash       2 weeks ago   Exited (0) 2 weeks ago                            lucid_shtern
8c2596403ff2  quay.io/ibmmas/cli:latest          /bin/sh -c bash       2 weeks ago   Exited (0) 2 weeks ago                            relaxed_brahmagupta
b9ecb6fb2d61  quay.io/ibmmas/cli:7.8.0           /bin/sh -c bash       2 weeks ago   Exited (0) 2 weeks ago                            adoring_khayyam
ee3efa6fa401  quay.io/ibmmas/cli:latest          /bin/sh -c bash       2 weeks ago   Exited (0) 2 weeks ago                            trusting_bouman
f49ddbb4c603  quay.io/ibmmas/cli:7.8.0           /bin/sh -c bash       2 weeks ago   Exited (129) 13 days ago                          busy_bhabha
```

delete containers:  
```
podman rm 40e0838dfc67 8c2596403ff2 b9ecb6fb2d61 ee3efa6fa401 f49ddbb4c603
```

list images:  
```
podman images
REPOSITORY                  TAG         IMAGE ID      CREATED       SIZE
quay.io/ibmmas/cli          7.8.0       72910fc0b9c0  2 weeks ago   2.71 GB
quay.io/ibmmas/cli          latest      a246db052142  3 months ago  2.6 GB
docker.io/library/registry  latest      0030ba3d620c  4 months ago  24.6 MB
```

delete images:  
```
podman rmi 72910fc0b9c0
Untagged: quay.io/ibmmas/cli:7.8.0
Deleted: 72910fc0b9c031cae7124e89e925589e8d5ceba54c6078c7ae9e7db701399363
```


start the cli image:  
```
podman run -ti -d -v -name mascli /images:/images:z -v ~:/mnt/home:z --pull always quay.io/ibmmas/cli
```
NOTE: before installing, copy the license file to one of the mounted folders on the host.  

connect to a running container:  
```
podman exec -ti mascli /bin/bash
```
  
stop and start container:  
```
podman stop mascli
podman start mascli
```
