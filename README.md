## Helm Charts for installing and managing Infinispan clusters

### Install cluster

```
helm install <cluster name> . -n <namespace> --set replicas=2 ...
```

### Test cluster connection

```
helm test <cluster name> -n <namespace>
```

### Uninstall cluster
```
helm uninstall <cluster name> -n <namespace>
```

#DON'T MERGE!
