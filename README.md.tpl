## Helm Chart for {brandname}

A Helm chart that lets you build and deploy [{brandname}]({website}) Server clusters.

## Build configuration

Configure the container images for {brandname} Server pods by specifying values in the `images.*` section of this chart.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `images.server` | FQN of the {brandname} Server image to deploy. | `{serverImage}` | - |
| `images.initContainer` | FQN of a minimal Linux container for the initContainer. | `registry.access.redhat.com/ubi8-micro` | - |

## Deployment configuration

Configure your {brandname} cluster by specifying values in the `deploy.*` section of this chart.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `deploy.clusterDomain` | Specifies the internal Kubernetes cluster domain. | cluster.local | - |
| `deploy.replicas` | Specifies the number of nodes in your {brandname} cluster, with a pod created for each node. | 1 | - |
| `deploy.container.extraJvmOpts` | Passes JVM options to {brandname} Server. | `""` | - |
| `deploy.container.libraries` | Libraries to be downloaded before server startup. | `""` | Specify multiple, space-separated artifacts represented as URLs or as Maven coordinates. Archive artifacts in .tar, .tar.gz or .zip formats will be extracted. |
| `deploy.container.storage.ephemeral` | Defines whether storage is ephemeral or permanent. | false | Set the value to `true` to use ephemeral storage, which means all stored data is deleted when clusters shut down or restart. |
| `deploy.container.storage.size` | Defines how much storage is allocated to each {brandname} pod. | 1Gi | - |
| `deploy.container.storage.storageClassName` | Specifies the name of a `StorageClass` object to use for the persistent volume claim (PVC). | `""` | By default, the persistent volume claim uses the storage class that has the `storageclass.kubernetes.io/is-default-class` annotation set to `true`. If you include this field, you must specify an existing storage class as the value. |
| `deploy.container.resources.limits.cpu` | Defines the CPU limit, in CPU units, for each {brandname} pod. | 500m | - |
| `deploy.container.resources.limits.memory` | Defines the memory limit, in bytes, for each {brandname} pod. | 512Mi | - |
| `deploy.container.resources.requests.cpu` | Specifies the maximum CPU requests, in CPU units, for each {brandname} pod. | 500m | - |
| `deploy.container.resources.requests.memory` | Specifies the maximum memory requests, in bytes, for each {brandname} pod. | 512Mi | - |
| `deploy.security.secretName` | Specifies the name of a secret that creates credentials and configures security authorization. | `""` | If you provide a security secret then `deploy.security.batch` does not take effect. |
| `deploy.security.batch` | Provides a batch file for the {brandname} command line interface (CLI) to create credentials and configure security authorization. | `""` | The CLI runs the batch file before server startup. |
| `deploy.expose.type` | Specifies the service that exposes Hot Rod and REST endpoints outside the {k8s} cluster and allows network access to your {brandname} cluster. | Route | Valid options: `["", "Route", "LoadBalancer", "NodePort"]`. Set an empty value (`""`) if you do not want to expose {brandname} on the network. |
| `deploy.expose.nodePort` | Specifies a network port for node port services within the default range of 30000 to 32767. | 0 | If you do not specify a port, the platform selects an available one. |
| `deploy.expose.host` | Specifies the hostname where the {ingress} is exposed, if required. | `""` | |
| `deploy.expose.annotations` | Adds annotations to the service that exposes {brandname} on the network. | `{}` | - |
| `deploy.logging.categories` | Configures {brandname} cluster log categories and levels. | `{}` | - |
| `deploy.podLabels` | Adds labels to each Infinispan pod that you create. | `{}` | - |
| `deploy.svcLabels` | Adds labels to each service that you create.| `{}` | - |
| `deploy.resourceLabels` | Adds labels to all {brandname} resources including pods and services. | `{}` | - |
| `deploy.tolerations` | Node taints to tolerate | `[]` | - |
| `deploy.makeDataDirWritable` | Allows write access to the `data` directory for each {brandname} Server node. | false | Setting the value to `true` creates an initContainer that runs `chmod -R` on the `/opt/infinispan/server/data` directory and changes its permissions. |
| `deploy.monitoring.enabled` | Enable/disable ServiceMonitor functionality. | false | - |
| `deploy.nameOverride` | Specifies a name for all {brandname} cluster resources. | Helm Chart release name | Configure a name for the created resources only if you need it to be different to the Helm Chart release name. |
| `deploy.infinispan` | {brandname} Server configuration. | - | You should not change the default socket bindings or the security realm and endpoints named "metrics". Modifying these default properties can result in unexpected behavior and loss of service. |
