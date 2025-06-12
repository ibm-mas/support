# troubleshooting - issues - steps

install failed to install pipeline operator:

openshift was then missing some images from quay.io registry.redhat.io registry.connect.redhat.com
workaround for getting mas to install:
vi /opt/app-root/lib/python3.9/site-packages/ansible_collections/ibm/mas_devops/roles/ocp_simulate_disconnected_network/defaults/main.yml 
remove the 3 registries.


install fail to get cli image:

Failed to validate quay.io/ibmmas/cli@sha256:ab4a5c6da4bedd176de448be90c871b5228dc09d39b2eacf358ba90a9cf712c4 in the target OCP cluster


oc image mirror quay.io/ibmmas/cli:7.10.1 ibmmas/cli:7.10.1 -a /images/config.json 
/
  ibmmas/cli
    blobs:
      quay.io/ibmmas/cli sha256:224dcd93401e12aad5b726f4a1d4cfc303345fcbd140b9648476ec7b781754ef 105B
      quay.io/ibmmas/cli sha256:b638dd0c3134925e23eeda5e61508edca9d6751d156a2fd53539f44a9b3ddd99 407B
      quay.io/ibmmas/cli sha256:c6327845777b7b00c5e0e2b403148c36d58c3e0f58fd28e061e37e5776e23be3 422B
      quay.io/ibmmas/cli sha256:464c5bc0faba68c4f860d1a5796dce46bd9b14ffe27d8d5906d10389838079b0 1.645KiB
      quay.io/ibmmas/cli sha256:bbc6a74ba9f44b813a64a43693fab5d05cf499cf5393e1a5253f04cd590aec52 3.745KiB
      quay.io/ibmmas/cli sha256:706de80aa95d67306da2318997b2ded2a46fbf7c0f986b3dd9d80f365364ebdf 6.384KiB
      quay.io/ibmmas/cli sha256:f22cf6e6f85d06a49194d0a722483dccf433790225a660c3298acd5dd0989fd3 9.438KiB
      quay.io/ibmmas/cli sha256:31ee7033ac94efd92556cf57fff7c899ad626f561ab62a45de5f12524fae25bd 9.445KiB
      quay.io/ibmmas/cli sha256:90de7fdad9f9dd4eaa775bd2bf841865b51b1e9bc03203f30c7375db21930c0c 29.62KiB
      quay.io/ibmmas/cli sha256:11814f610b240c5787f6658b1c9fa6a30aed7cd87d863aeceb11fd5237a16a85 112.3KiB
      quay.io/ibmmas/cli sha256:c620558b85ce9141c2e913643de5072e8f084e34b95b8aa3379e58c8441cf5aa 1.646MiB
      quay.io/ibmmas/cli sha256:da8e579350ebd10965fb2b4cb51781df942405938026bfef9cbd9597a78bcd29 12.59MiB
      quay.io/ibmmas/cli sha256:1f76d245924ab2654041b6b01fb85c14afd06654e06704081872e8b5a1598ff0 17.72MiB
      quay.io/ibmmas/cli sha256:8c784caf9b7fa4acf536fdebdbffb64c09accd97f3b9c6c280791d5807df608b 73.68MiB
      quay.io/ibmmas/cli sha256:94d0035314a138da8f92422fcfa9553d7c1f626322cedc78ddd8e545f4e60f4e 75.29MiB
      quay.io/ibmmas/cli sha256:e59f6edab1ac3b4e3c67d9d58e64023b04af42c726feeefa7ceb058e72dac124 76.6MiB
      quay.io/ibmmas/cli sha256:be73b5c2021d572dd7ef2134b85490f54590881904f62d61e8237035bf1646ea 144.7MiB
      quay.io/ibmmas/cli sha256:2926ced57f19b2e8b284e4ab12517922ec92251cda92cb83b98fb9c766e7b2f9 416MiB
    manifests:
      sha256:ab4a5c6da4bedd176de448be90c871b5228dc09d39b2eacf358ba90a9cf712c4 -> 7.10.1
  stats: shared=0 unique=18 size=818.4MiB ratio=1.00

phase 0:
   ibmmas/cli blobs=18 mounts=0 manifests=1 shared=0
[...]
error: unable to push quay.io/ibmmas/cli: failed to upload blob sha256:464c5bc0faba68c4f860d1a5796dce46bd9b14ffe27d8d5906d10389838079b0: Get "https://image-registry1.fyre.ibm.com:5000/v2/": tls: failed to verify certificate: x509: certificate signed by unknown authority


had to add the certificate to the trusted certificate on the cli image where running the oc image mirror command from:
cp /images/certs/domain.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust

it then completed:
[...]
uploading: image-registry1.fyre.ibm.com:5000/ibmmas/cli sha256:8c784caf9b7fa4acf536fdebdbffb64c09accd97f3b9c6c280791d5807df608b 73.68MiB
uploading: image-registry1.fyre.ibm.com:5000/ibmmas/cli sha256:da8e579350ebd10965fb2b4cb51781df942405938026bfef9cbd9597a78bcd29 12.59MiB
uploading: image-registry1.fyre.ibm.com:5000/ibmmas/cli sha256:c620558b85ce9141c2e913643de5072e8f084e34b95b8aa3379e58c8441cf5aa 1.646MiB
sha256:ab4a5c6da4bedd176de448be90c871b5228dc09d39b2eacf358ba90a9cf712c4 image-registry1.fyre.ibm.com:5000/ibmmas/cli:7.10.1
info: Mirroring completed in 11.1s (77.26MB/s)


=========


=========
image pullbackoff error

Failed to pull image "quay.io/ibmmas/cli:13.13.0": (Mirrors also failed: [ml-registry1.fyre.ibm.com:5000/ibmmas/cli:13.13.0: reading manifest 13.13.0 in ml-registry1.fyre.ibm.com:5000/ibmmas/cli: manifest unknown]): quay.io/ibmmas/cli:13.13.0: registry quay.io/ibmmas is blocked in /etc/containers/registries.conf or /root/.config/containers/registries.conf.d

check the image is in the registry
/images/data/docker/registry/v2/repositories/ibmmas/cli/_manifests/tags/13.13.0

manually copy it using skopeo:
skopeo copy docker://quay.io/ibmmas/cli:13.13.0 docker://ml-registry1.fyre.ibm.com:5000/ibmmas/cli:13.13.0


Failed to pull image "quay.io/ibmmas/mongo@sha256:34341de709b1a70f5e0339ecb1ad2aa2152ecf88e5ca825e2a764da69bbd0269": registry quay.io/ibmmas is blocked in /etc/containers/registries.conf or /root/.config/containers/registries.conf.d

check you have an entry in idms

if it is pulling using a tag, you need to have an entry in itms


