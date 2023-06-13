# infinispan

![Version: 0.3.1](https://img.shields.io/badge/Version-0.3.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 14.0](https://img.shields.io/badge/AppVersion-14.0-informational?style=flat-square)

A Helm chart that lets you build and deploy Infinispan clusters.

**Homepage:** <https://infinispan.org/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Infinispan |  | <https://infinispan.org/> |

## Source Code

* <https://github.com/infinispan/infinispan>
* <https://github.com/infinispan/infinispan-helm-charts>

## Requirements

Kubernetes: `>= 1.21.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| images.server | string | `"quay.io/infinispan/server:14.0"` |  |
| images.initContainer | string | `"registry.access.redhat.com/ubi8-micro"` |  |
| deploy.replicas | int | `1` |  |
| deploy.clusterDomain | string | `"cluster.local"` |  |
| deploy.container.extraJvmOpts | string | `""` |  |
| deploy.container.libraries | string | `""` |  |
| deploy.container.env | string | `nil` |  |
| deploy.container.storage.size | string | `"1Gi"` |  |
| deploy.container.storage.storageClassName | string | `""` |  |
| deploy.container.storage.ephemeral | bool | `false` |  |
| deploy.container.resources.limits.cpu | string | `"500m"` |  |
| deploy.container.resources.limits.memory | string | `"512Mi"` |  |
| deploy.container.resources.requests.cpu | string | `"500m"` |  |
| deploy.container.resources.requests.memory | string | `"512Mi"` |  |
| deploy.security.secretName | string | `""` |  |
| deploy.security.batch | string | `""` |  |
| deploy.expose.type | string | `"Route"` |  |
| deploy.expose.nodePort | int | `0` |  |
| deploy.expose.host | string | `""` |  |
| deploy.expose.annotations | list | `[]` |  |
| deploy.monitoring.enabled | bool | `false` |  |
| deploy.logging.categories[0].category | string | `"com.arjuna"` |  |
| deploy.logging.categories[0].level | string | `"warn"` |  |
| deploy.logging.categories[1].category | string | `"io.netty.handler.ssl.ApplicationProtocolNegotiationHandler"` |  |
| deploy.logging.categories[1].level | string | `"error"` |  |
| deploy.makeDataDirWritable | bool | `false` |  |
| deploy.nameOverride | string | `""` |  |
| deploy.resourceLabels | list | `[]` |  |
| deploy.podLabels | list | `[]` |  |
| deploy.svcLabels | list | `[]` |  |
| deploy.tolerations | list | `[]` |  |
| deploy.nodeAffinity | object | `{}` |  |
| deploy.nodeSelector | object | `{}` |  |
| deploy.infinispan.cacheContainer.name | string | `"default"` |  |
| deploy.infinispan.cacheContainer.security.authorization | object | `{}` |  |
| deploy.infinispan.cacheContainer.transport.cluster | string | `"${infinispan.cluster.name:cluster}"` |  |
| deploy.infinispan.cacheContainer.transport.node-name | string | `"${infinispan.node.name:}"` |  |
| deploy.infinispan.cacheContainer.transport.stack | string | `"kubernetes"` |  |
| deploy.infinispan.server.endpoints[0].securityRealm | string | `"default"` |  |
| deploy.infinispan.server.endpoints[0].socketBinding | string | `"default"` |  |
| deploy.infinispan.server.endpoints[0].connectors.rest.restConnector | string | `nil` |  |
| deploy.infinispan.server.endpoints[0].connectors.hotrod.hotrodConnector | string | `nil` |  |
| deploy.infinispan.server.endpoints[1].connectors.rest.restConnector.authentication.mechanisms | string | `"BASIC"` |  |
| deploy.infinispan.server.endpoints[1].securityRealm | string | `"metrics"` |  |
| deploy.infinispan.server.endpoints[1].socketBinding | string | `"metrics"` |  |
| deploy.infinispan.server.interfaces[0].inetAddress.value | string | `"${infinispan.bind.address:127.0.0.1}"` |  |
| deploy.infinispan.server.interfaces[0].name | string | `"public"` |  |
| deploy.infinispan.server.security.credentialStores[0].clearTextCredential.clearText | string | `"secret"` |  |
| deploy.infinispan.server.security.credentialStores[0].name | string | `"credentials"` |  |
| deploy.infinispan.server.security.credentialStores[0].path | string | `"credentials.pfx"` |  |
| deploy.infinispan.server.security.securityRealms[0].name | string | `"default"` |  |
| deploy.infinispan.server.security.securityRealms[0].propertiesRealm.groupProperties.path | string | `"groups.properties"` |  |
| deploy.infinispan.server.security.securityRealms[0].propertiesRealm.groupsAttribute | string | `"Roles"` |  |
| deploy.infinispan.server.security.securityRealms[0].propertiesRealm.userProperties.path | string | `"users.properties"` |  |
| deploy.infinispan.server.security.securityRealms[1].name | string | `"metrics"` |  |
| deploy.infinispan.server.security.securityRealms[1].propertiesRealm.groupProperties.path | string | `"metrics-groups.properties"` |  |
| deploy.infinispan.server.security.securityRealms[1].propertiesRealm.groupProperties.relativeTo | string | `"infinispan.server.config.path"` |  |
| deploy.infinispan.server.security.securityRealms[1].propertiesRealm.groupsAttribute | string | `"Roles"` |  |
| deploy.infinispan.server.security.securityRealms[1].propertiesRealm.userProperties.path | string | `"metrics-users.properties"` |  |
| deploy.infinispan.server.security.securityRealms[1].propertiesRealm.userProperties.relativeTo | string | `"infinispan.server.config.path"` |  |
| deploy.infinispan.server.socketBindings.defaultInterface | string | `"public"` |  |
| deploy.infinispan.server.socketBindings.portOffset | string | `"${infinispan.socket.binding.port-offset:0}"` |  |
| deploy.infinispan.server.socketBindings.socketBinding[0].name | string | `"default"` |  |
| deploy.infinispan.server.socketBindings.socketBinding[0].port | int | `11222` |  |
| deploy.infinispan.server.socketBindings.socketBinding[1].name | string | `"metrics"` |  |
| deploy.infinispan.server.socketBindings.socketBinding[1].port | int | `11223` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
