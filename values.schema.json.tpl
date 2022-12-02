{
    "properties": {
        "images": {
            "description": "Sets the images used by the {brandname} cluster.",
            "properties": {
                "server": {
                    "description": "{brandname} Server image.",
                    "type": [
                        "string",
                        "null"
                    ]
                },
                "initContainer": {
                    "description": "Base image for initContainers.",
                    "type": [
                        "string",
                        "null"
                    ]
                }
            },
            "type": [
                "object",
                "null"
            ]
        },
        "deploy": {
            "description": "Configuration properties for {brandname} clusters.",
            "properties": {
                "monitoring": {
                    "description": "Configuration for ServiceMonitor",
                    "properties": {
                        "enabled": {
                            "description": "Enable/disable ServiceMonitor functionality",
                            "type": "boolean"
                        }
                    },
                    "type": [
                        "object",
                        "null"
                    ]
                },
                "replicas": {
                    "description": "The internal Kubernetes cluster domain.",
                    "type": "string",
                    "default": "cluster.local"
                },
                "replicas": {
                    "description": "Number of pods in the {brandname} cluster.",
                    "type": "integer"
                },
                "container": {
                    "description": "JVM, CPU, and memory resources for {brandname} pods.",
                    "properties": {
                        "extraJvmOpts": {
                            "description": "Passes JVM options to {brandname} Server.",
                            "type": [
                                "string",
                                "null"
                            ]
                        },
                        "storage": {
                            "description": "Storage resources for {brandname} pods.",
                            "properties": {
                                "ephemeral": {
                                    "description": "Defines whether storage is ephemeral or permanent. If true, then all persisted data is deleted when clusters shut down or restart.",
                                    "type": "boolean"
                                },
                                "size": {
                                    "description": "Defines how much storage is allocated to each {brandname} pod.",
                                    "type": "string"
                                },
                                "storageClassName": {
                                    "description": "Specifies the name of a `StorageClass` object to use for the persistent volume claim (PVC).",
                                    "type": [
                                        "string",
                                        "null"
                                    ]
                                }
                            },
                            "type": [
                                "object",
                                "null"
                            ]
                        },
                        "resources": {
                            "description": "CPU and Memory resources for {brandname} pods.",
                            "properties": {
                                "limits": {
                                    "properties": {
                                        "cpu": {
                                            "description": "Defines the CPU limit, in CPU units, for each {brandname} pod.",
                                            "type": "string"
                                        },
                                        "memory": {
                                            "description": "Defines the memory limit, in bytes, for each {brandname} pod.",
                                            "type": "string"
                                        }
                                    },
                                    "type": [
                                        "object",
                                        "null"
                                    ]
                                },
                                "requests": {
                                    "properties": {
                                        "cpu": {
                                            "description": "Specifies the maximum CPU requests, in CPU units, for each {brandname} pod.",
                                            "type": "string"
                                        },
                                        "memory": {
                                            "description": "Specifies the maximum memory requests, in bytes, for each {brandname} pod.",
                                            "type": "string"
                                        }
                                    },
                                    "type": [
                                        "object",
                                        "null"
                                    ]
                                }
                            },
                            "type": [
                                "object",
                                "null"
                            ]
                        }
                    },
                    "type": [
                        "object",
                        "null"
                    ]
                },
                "security": {
                    "description": "Controls access to {brandname} clusters.",
                    "properties": {
                        "secretName": {
                            "description": "Specifies the name of a secret that creates credentials and configures security authorization.",
                            "type": [
                                "string",
                                "null"
                            ]
                        },
                        "batch": {
                            "description": "Provides a batch file for the {brandname} command line interface (CLI) to create credentials and configure security authorization.",
                            "type": [
                                "string",
                                "null"
                            ]
                        }
                    },
                    "type": [
                        "object",
                        "null"
                    ]
                },
                "expose": {
                    "description": "Controls network access to {brandname} Server endpoints.",
                    "properties": {
                        "type": {
                            "description": "Specifies the service that exposes Hot Rod and REST endpoints on the network. Set an empty value (\"\") if you do not want to allow network access to {brandname}.",
                            "enum": [
                                "",
                                "LoadBalancer",
                                "NodePort",
                                "Route"
                            ],
                            "type": [
                                "string",
                                "null"
                            ],
                            "default": ""
                        },
                        "nodeport": {
                            "description": "Specifies a network port for load balancer and node port services.",
                            "type": "integer"
                        },
                        "host": {
                            "description": "Optionally specifies the hostname where the service is exposed.",
                            "type": [
                                "string",
                                "null"
                            ]
                        },
                        "annotations": {
                            "description": "Adds annotations to the service that exposes {brandname} on the network.",
                            "items": {
                                "properties": {
                                    "key": {
                                        "type": "string"
                                    },
                                    "value": {
                                        "type": "string"
                                    }
                                },
                                "required": [
                                    "key",
                                    "value"
                                ]
                            },
                            "type": [
                                "array",
                                "null"
                            ]
                        }
                    },
                    "type": [
                        "object",
                        "null"
                    ]
                },
                "logging": {
                    "description": "Configures logging categories and levels for {brandname} Server.",
                    "properties": {
                        "categories": {
                            "description": "Adjusts the type and number of messages that {brandname} logs.",
                            "items": {
                                "properties": {
                                    "category": {
                                        "description": "Specifies the FQN of a {brandname} package for which you want to configure logging.",
                                        "type": "string"
                                    },
                                    "level": {
                                        "description": "Specifies the level at which {brandname} logs messages for this package.",
                                        "default": "info",
                                        "enum": [
                                            "trace",
                                            "debug",
                                            "info",
                                            "warn",
                                            "error"
                                        ],
                                        "type": "string"
                                    }
                                },
                                "required": [
                                    "category",
                                    "level"
                                ]
                            },
                            "title": "Category",
                            "type": [
                                "array",
                                "null"
                            ]
                        }
                    }
                },
                "podLabels": {
                    "description": "Adds labels to every pod created",
                    "items": {
                        "properties": {
                            "key": {
                                "type": "string"
                            },
                            "value": {
                                "type": "string"
                            }
                        },
                        "required": [
                            "key",
                            "value"
                        ]
                    },
                    "type": [
                        "array",
                        "null"
                    ]
                },
                "svcLabels": {
                    "description": "Adds labels to every service created",
                    "items": {
                        "properties": {
                            "key": {
                                "type": "string"
                            },
                            "value": {
                                "type": "string"
                            }
                        },
                        "required": [
                            "key",
                            "value"
                        ]
                    },
                    "type": [
                        "array",
                        "null"
                    ]
                },
                "resourceLabels": {
                    "description": "Adds labels to {brandname} resources such as pods and services.",
                    "items": {
                        "properties": {
                            "key": {
                                "type": "string"
                            },
                            "value": {
                                "type": "string"
                            }
                        },
                        "required": [
                            "key",
                            "value"
                        ]
                    },
                    "type": [
                        "array",
                        "null"
                    ]
                }
            },
            "type": [
                "object",
                "null"
            ]
        }
    },
    "$schema": "http://json-schema.org/schema#",
    "type": "object"
}
