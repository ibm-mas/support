# Mirror RedHat images

mas mirror-redhat-images  


get pull secret:  
[https://ibm-mas.github.io/cli/commands/mirror-redhat-images/](https://console.redhat.com/openshift/downloads#tool-pull-secret)  
 copy it in a file in the container:  

```
echo '{"auths":{"cloud.openshift.com":{"auth":"b3BlbnNoaW...ONzRDOEc1MA==","email":"matthieulrx@nl.ibm.com"},"quay.io":{"auth":"b3BlbnNo...Ec1MA==","email":"matthieulrx@nl.ibm.com"},"registry.connect.redhat.com":{"auth":"fHVoYy...hDcHl2MWphaw==","email":"matthieulrx@nl.ibm.com"},"registry.redhat.io":{"auth":"fHVoYy1wb29sL...DcHl2MWphaw==","email":"matthieulrx@nl.ibm.com"}}}' > /images/pullsecret.txt
```

## Troubleshooting

The command had to be executed several time to get to completion

## References

[https://ibm-mas.github.io/cli/commands/mirror-redhat-images/](https://ibm-mas.github.io/cli/commands/mirror-redhat-images/)