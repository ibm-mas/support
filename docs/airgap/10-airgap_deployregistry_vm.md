# Deploy registry to a vm



## Install Podman and httpd-tools  
Install the podman package to run the registry. The httpd-tools package provides the htpasswd utility for authentication.
```
yum install -y podman httpd-tools
```

## Create folders for the registry
The registry will be stored in /images/ on the host system and the respective directories are mounted in the container running the registry.
```
mkdir -p /images/{auth,certs,data}
```

## Generate credentials for accessing the registry

Use the htpasswd utility to generate a file containing the credentials for accessing the registry:
```
htpasswd -bBc /images/auth/htpasswd admin redhat
```
A Bcrypt Htpasswd file named htpasswd will be created in the /images/auth/ directory.

## Generate TLS key pair
The registry is secured with TLS by using a key and certificate signed by a trusted authority (internal or external) or by a simple self-signed certificate. To use a self-signed certificate:

```
cd /images/certs/
REGISTRY_HOST=img-registry1.fyre.ibm.com
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 365 -key ca.key -subj "/C=NL/ST=NH/L=AMS/O=IBM-SUPPORT/CN=Acme Root CA" -out ca.crt
openssl req -newkey rsa:2048 -nodes -keyout server.key -subj "/C=NL/ST=NH/L=AMS/O=IBM-SUPPORT/CN=$REGISTRY_HOST" -out server.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:$REGISTRY_HOST") -days 3650 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt
```

## Copy the certificates 
```
# cp /images/certs/server.crt /etc/pki/ca-trust/source/anchors/
cp /images/certs/ca.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust
trust list | grep -i "$REGISTRY_HOST"
```

## Start the registy pod:
```
podman run --name myregistry \
-p 5000:5000 \
-v /images/data:/var/lib/registry:z \
-v /images/auth:/auth:z \
-e "REGISTRY_AUTH=htpasswd" \
-e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
-v /images/certs:/certs:z \
-e "REGISTRY_HTTP_TLS_CERTIFICATE=/certs/server.crt" \
-e "REGISTRY_HTTP_TLS_KEY=/certs/server.key" \
-e REGISTRY_COMPATIBILITY_SCHEMA1_ENABLED=true \
-e REGISTRY_STORAGE_DELETE_ENABLED=true \
-d \
docker.io/library/registry:latest
```
  
Note: If a firewall is running on the hosts, the exposed port (5000) will need to be permitted. To open the port:  
```  
firewall-cmd --add-port=5000/tcp --zone=internal --permanent
firewall-cmd --add-port=5000/tcp --zone=public --permanent
firewall-cmd --reload
```

verify you can access the registry:
```
curl https://admin:redhat@$REGISTRY_HOST:5000/v2/_catalog
```

## Troubleshooting

1- The certificate can be verified using:  
```
$ openssl s_client -connect <servername>:5000 -servername <servername>
```
Be sure to trust the certificate from earlier or use curl's -k switch to ignore certificate verification.


2- Check that the registry pod is running:  
```
podman ps
CONTAINER ID  IMAGE                              COMMAND               CREATED       STATUS      PORTS                   NAMES
cf0c6c8397d7  docker.io/library/registry:latest  /etc/docker/regis...  3 months ago  Up 2 weeks  0.0.0.0:5000->5000/tcp  myregistry
```

3- When running the podman pull command you may get:  
```
Trying to pull docker.io/library/registry:latest...  
WARN[0038] Failed, retrying in 1s ... (1/3). Error: copying system image from manifest list: determining manifest MIME type for docker://registry:latest: reading manifest sha256:46faa9a1ae6813194b53921a370f2f4f8c5e1aae228a89bceafef5847a6a3278 in docker.io/library/registry: toomanyrequests: You have reached your unauthenticated pull rate limit. https://www.docker.com/increase-rate-limit
```
if that is the case, login to docker.io:  
```
podman login docker.io
```
  
  
  
  
### References:  
  [https://www.redhat.com/sysadmin/simple-container-registry](https://www.redhat.com/sysadmin/simple-container-registry)  
  [https://docs.docker.com/docker-hub/usage/](https://docs.docker.com/docker-hub/usage/)  
    




    