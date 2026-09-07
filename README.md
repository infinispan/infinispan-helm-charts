## Helm Chart for Infinispan

A Helm chart that lets you build and deploy [Infinispan](https://infinispan.org) Server clusters.

## Build configuration

Configure the container images for Infinispan Server pods by specifying values in the `images.*` section of this chart.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `images.server` | FQN of the Infinispan Server image to deploy. | `quay.io/infinispan/server:16.2` | - |
| `images.initContainer` | FQN of a minimal Linux container for the initContainer. | `registry.access.redhat.com/ubi8-micro` | - |

## Deployment configuration

Configure your Infinispan cluster by specifying values in the `deploy.*` section of this chart.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `deploy.clusterDomain` | Specifies the internal Kubernetes cluster domain. | cluster.local | - |
| `deploy.replicas` | Specifies the number of nodes in your Infinispan cluster, with a pod created for each node. | 1 | - |
| `deploy.container.imagePullSecrets` | Image pull secrets for pulling from a private registry. | `[]` | Reference a k8s secret containing credentials for pulling image from a private registry. |
| `deploy.container.imagePullPolicy` | The Infinispan image pull policy. | `"Always"` | - |
| `deploy.container.extraJvmOpts` | Passes JVM options to Infinispan Server. | `""` | - |
| `deploy.container.libraries` | Libraries to be downloaded before server startup. | `""` | Specify multiple, space-separated artifacts represented as URLs or as Maven coordinates. Archive artifacts in .tar, .tar.gz or .zip formats will be extracted. |
| `deploy.container.env` | Additional environment variables in K8s format. | `""` | See docs for examples of [strings](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/#using-environment-variables-inside-of-your-config), [ConfigMaps](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#define-container-environment-variables-with-data-from-multiple-configmaps) and [Secrets](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/#define-container-environment-variables-with-data-from-multiple-secrets) |
| `deploy.container.storage.ephemeral` | Defines whether storage is ephemeral or permanent. | false | Set the value to `true` to use ephemeral storage, which means all stored data is deleted when clusters shut down or restart. |
| `deploy.container.storage.size` | Defines how much storage is allocated to each Infinispan pod. | 1Gi | - |
| `deploy.container.storage.storageClassName` | Specifies the name of a `StorageClass` object to use for the persistent volume claim (PVC). | `""` | By default, the persistent volume claim uses the storage class that has the `storageclass.kubernetes.io/is-default-class` annotation set to `true`. If you include this field, you must specify an existing storage class as the value. |
| `deploy.container.resources.limits.cpu` | Defines the CPU limit, in CPU units, for each Infinispan pod. | 500m | - |
| `deploy.container.resources.limits.memory` | Defines the memory limit, in bytes, for each Infinispan pod. | 512Mi | - |
| `deploy.container.resources.requests.cpu` | Specifies the maximum CPU requests, in CPU units, for each Infinispan pod. | 500m | - |
| `deploy.container.resources.requests.memory` | Specifies the maximum memory requests, in bytes, for each Infinispan pod. | 512Mi | - |
| `deploy.security.secretName` | Specifies the name of a secret that creates credentials and configures security authorization. | `""` | If you provide a security secret then `deploy.security.batch` does not take effect. |
| `deploy.security.batch` | Provides a batch file for the Infinispan command line interface (CLI) to create credentials and configure security authorization. | `""` | The CLI runs the batch file before server startup. |
| `deploy.expose.type` | Specifies the service that exposes Hot Rod and REST endpoints outside the Kubernetes cluster and allows network access to your Infinispan cluster. | Route | Valid options: `["", "Route", "LoadBalancer", "NodePort"]`. Set an empty value (`""`) if you do not want to expose {brandname} on the network. |
| `deploy.expose.nodePort` | Specifies a network port for node port services within the default range of 30000 to 32767. | 0 | If you do not specify a port, the platform selects an available one. |
| `deploy.expose.host` | Specifies the hostname where the Ingress is exposed, if required. | `""` | |
| `deploy.expose.annotations` | Adds annotations to the service that exposes Infinispan on the network. | `{}` | - |
| `deploy.logging.console.json` | Outputs logs as JSON on stdout instead of the default colored text format. Useful for log aggregation pipelines (ELK, Loki, etc.). Each log line includes `time`, `service`, `namespace`, and `pod` fields. | `false` | The `POD_NAME` and `POD_NAMESPACE` environment variables are automatically injected via the Downward API and used to populate the `pod` and `namespace` fields. |
| `deploy.logging.categories` | Configures Infinispan cluster log categories and levels. | `{}` | - |
| `deploy.podAnnotations` | Adds annotations to each Infinispan pod that you create. | `{}` | - |
| `deploy.podLabels` | Adds labels to each Infinispan pod that you create. | `{}` | When `deploy.usePrefixedLabels` is `false`, the keys `app` and `clusterName` are reserved and ignored. When `true`, the keys `infinispan_app` and `infinispan_clusterName` are reserved and ignored. |
| `deploy.svcLabels` | Adds labels to each service that you create.| `{}` | - |
| `deploy.resourceLabels` | Adds labels to all Infinispan resources including pods and services. | `{}` | - |
| `deploy.tolerations` | Node taints to tolerate | `[]` | - |
| `deploy.nodeSelector` | Defines the nodeSelector policy used by the cluster's StatefulSet | `{}` | - |
| `deploy.nodeAffinity` | Defines the nodeAffinity policy used by the cluster's StatefulSet | `{}` | - |
| `deploy.podAffinity` | Defines the podAffinity policy used by the cluster's StatefulSet | `{}` | - |
| `deploy.podAntiAffinity` | Defines the podAntiAffinity policy used by the cluster's StatefulSet | <pre><code>podAntiAffinity: ><br>preferredDuringSchedulingIgnoredDuringExecution:<br>      - podAffinityTerm:<br>          labelSelector:<br>            matchLabels:<br>              clusterName: {{ include "infinispan-helm-charts.name" . }}<br>              app: infinispan-pod<br>          topologyKey: kubernetes.io/hostname<br>        weight: 100</code></pre> | Default selector labels in this rule automatically reflect the value of `deploy.usePrefixedLabels`. |
| `deploy.makeDataDirWritable` | Allows write access to the `data` directory for each Infinispan Server node. | false | Setting the value to `true` creates an initContainer that runs `chmod -R` on the `/opt/infinispan/server/data` directory and changes its permissions. |
| `deploy.monitoring.enabled` | Enable or disable `ServiceMonitor` functionality. | false | Users must have `monitoring-edit` role assigned by the admin to deploy the Helm chart with `ServiceMonitor` enabled. |
| `deploy.nameOverride` | Specifies a name for all Infinispan cluster resources. | Helm Chart release name | Configure a name for the created resources only if you need it to be different to the Helm Chart release name. |
| `deploy.usePrefixedLabels` | Use project-specific prefixed keys for internal selector labels to avoid collisions with admission controllers (e.g. Kyverno). | `false` | When `false`, selector labels use `app` and `clusterName`. When `true`, they use `infinispan_app` and `infinispan_clusterName`. Changing this value on an existing cluster requires deleting and recreating the StatefulSet due to the immutability of the `selector` field. |
| `deploy.securityContext` | Defines the securityContext settings used by the cluster's StatefulSet | `{}` | - |
| `deploy.ssl.endpointSecretName` | Specifies the name of the secret that contains certificate for endpoint encryption | `""` | - |
| `deploy.ssl.transportSecretName` | Specifies the name of the secret that contains certificate for transport encryption | `""` | - |
| `deploy.ssl.certmanager.endpoint.enabled` | Enable cert-manager to create the endpoint TLS secret | `false` | Requires cert-manager to be installed. Uses `deploy.ssl.endpointSecretName` as the secret name. |
| `deploy.ssl.certmanager.endpoint.issuerRef` | Reference to an existing Issuer or ClusterIssuer | - | If omitted, a self-signed Issuer is created automatically. |
| `deploy.ssl.certmanager.endpoint.keystorePassword` | Password for PKCS12 keystore generation | - | If provided, cert-manager generates a `keystore.p12` in the secret. |
| `deploy.ssl.certmanager.endpoint.additionalDnsNames` | Additional DNS names to include in the certificate | `[]` | Internal DNS names are computed automatically. |
| `deploy.ssl.certmanager.transport.enabled` | Enable cert-manager to create the transport TLS secret | `false` | Requires cert-manager to be installed. Uses `deploy.ssl.transportSecretName` as the secret name. |
| `deploy.ssl.certmanager.transport.issuerRef` | Reference to an existing Issuer or ClusterIssuer | - | If omitted, a self-signed Issuer is created automatically. |
| `deploy.ssl.certmanager.transport.keystorePassword` | Password for PKCS12 keystore generation | - | If provided, cert-manager generates a `keystore.p12` in the secret. |
| `deploy.ssl.certmanager.transport.additionalDnsNames` | Additional DNS names to include in the certificate | `[]` | Internal DNS names are computed automatically. |
| `deploy.volumeMounts` | Add custome volume mounts to infinispan | `[]` | - |
| `deploy.volumes` | Add custome volumes to infinispan | `[]` | - |
| `deploy.infinispan` | Infinispan Server configuration. | - | You should not change the default socket bindings or the security realm and endpoints named "metrics". Modifying these default properties can result in unexpected behavior and loss of service. |

## Cert-Manager Integration

This chart can automatically create TLS certificates using [cert-manager](https://cert-manager.io/).
Cert-manager must be installed in your cluster before enabling this feature.

### Basic Usage

To enable cert-manager for endpoint TLS, set the following values:

```yaml
deploy:
  ssl:
    endpointSecretName: "my-endpoint-cert"
    certmanager:
      endpoint:
        enabled: true
```

This creates a `Certificate` resource that provisions the secret specified by `endpointSecretName`.
DNS names for the certificate are computed automatically from the release name, namespace, and cluster domain.

### Custom Issuer

By default, a self-signed `Issuer` is created automatically. To use your own Issuer or ClusterIssuer:

```yaml
deploy:
  ssl:
    certmanager:
      endpoint:
        enabled: true
        issuerRef:
          name: my-issuer
          kind: ClusterIssuer
```

### PKCS12 Keystore

To include a PKCS12 keystore in the generated secret:

```yaml
deploy:
  ssl:
    certmanager:
      endpoint:
        enabled: true
        keystorePassword: "changeit"
```

### Transport TLS

Transport TLS secures internal cluster communication and can be enabled independently:

```yaml
deploy:
  ssl:
    endpointSecretName: "my-endpoint-cert"
    transportSecretName: "my-transport-cert"
    certmanager:
      endpoint:
        enabled: true
      transport:
        enabled: true
```

### Additional DNS Names

To add custom DNS names beyond the auto-computed entries:

```yaml
deploy:
  ssl:
    certmanager:
      endpoint:
        enabled: true
        additionalDnsNames:
          - "custom.example.com"
          - "*.example.com"
```
