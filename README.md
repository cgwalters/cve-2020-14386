# Reproducer for CVE-2020-14386

Pre-built container: `registry.svc.ci.openshift.org/coreos/cve-2020-14386`

You probably want to test against an explicit node, like this:

```
apiVersion: v1
kind: Pod
metadata:
  name: cve-2020-14386
spec:
  restartPolicy: Never
  nodeName: <yournode>
  containers:
  - name: cve-2020-14386
    image: registry.svc.ci.openshift.org/coreos/cve-2020-14386
    imagePullPolicy: Always
```

Replace `yournode` with a particular node you want to validate, then
`kubectl create -f pod.yaml` from the content above.
If your kernel is vulnerable, the node may crash or reboot; use e.g.
`kubectl get node/<nodename>` and check if the node goes `NotReady`
and reboots.

If the node is not vulnerable, then `kubectl logs pod/cve-2020-14386`
will show something like:
```
Running reproducer for CVE-2020-14386 in 5s - this may crash the node
Reproducer exited successfully - node probably not vulnerable
```
