# Blueprint Resources - Project: omendra-test01

## Summary

This document contains all resource configurations from the omendra-test01 project blueprint.

---

# aws_iam_role

## aws_iam_role/full-services-access

```json
{
  "disabled": false,
  "flavor": "default",
  "kind": "aws_iam_role",
  "metadata": {
    "name": "full-services-access",
    "namespace": "dagster"
  },
  "spec": {
    "irsa": {
      "service_accounts": {
        "arbitrary_name": {
          "name": "dagster"
        }
      }
    },
    "policies": {
      "AWSBatchFullAccess": {
        "arn": "arn:aws:iam::aws:policy/AWSBatchFullAccess"
      },
      "AWSXrayFullAccess": {
        "arn": "arn:aws:iam::aws:policy/AWSXrayFullAccess"
      },
      "AmazonEC2ContainerRegistryFullAccess": {
        "arn": "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
      },
      "AmazonEC2ContainerServiceRole": {
        "arn": "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
      },
      "AmazonECS_FullAccess": {
        "arn": "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
      },
      "AmazonS3FullAccess": {
        "arn": "arn:aws:iam::aws:policy/AmazonS3FullAccess"
      },
      "AmazonSNSFullAccess": {
        "arn": "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
      },
      "AmazonSSMReadOnlyAccess": {
        "arn": "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
      },
      "CloudWatchLogsFullAccess": {
        "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
      },
      "custom_policy": {
        "arn": "${iam_policy.full-services-access.out.attributes.arn}"
      }
    }
  },
  "version": "0.1"
}
```

---

## aws_iam_role/keda-role

```json
{
  "disabled": false,
  "flavor": "default",
  "kind": "aws_iam_role",
  "metadata": {
    "name": "keda-role",
    "namespace": "keda"
  },
  "spec": {
    "irsa": {
      "service_accounts": {
        "arbitrary_name": {
          "name": "keda-operator"
        }
      }
    },
    "policies": {
      "external_policy": {
        "arn": "arn:aws:iam::aws:policy/AmazonSQSReadOnlyAccess"
      }
    }
  },
  "version": "0.1"
}
```

---

## aws_iam_role/ol-sch-handler

```json
{
  "advanced": {
    "aws_iam_role": {
      "assume_role_policy": {
        "Statement": [
          {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
              "Service": "lambda.amazonaws.com"
            }
          }
        ],
        "Version": "2012-10-17"
      },
      "policies": {
        "external_policy": {
          "arn": "${iam_policy.ol-sch-handler.out.attributes.arn}"
        }
      },
      "tags": {
        "Module": "Scheduler",
        "Name": "OnelensSchedulerRequestHandler-Role",
        "Project": "Onyx"
      }
    }
  },
  "disabled": false,
  "flavor": "default",
  "kind": "aws_iam_role",
  "metadata": {
    "name": "ol-sch-handler"
  },
  "spec": {
    "irsa": {
      "service_accounts": {}
    },
    "name": "OnelensSchedulerRequestHandler-Role"
  },
  "uiProps": {},
  "version": "0.1"
}
```

---

## aws_iam_role/onyx-role

```json
{
  "disabled": false,
  "flavor": "default",
  "kind": "aws_iam_role",
  "metadata": {
    "name": "onyx-role"
  },
  "spec": {
    "irsa": {
      "oidc_providers": {
        "arbitrary_name": {
          "arn": "${kubernetes_cluster.default.out.attributes.legacy_outputs.k8s_details.oidc_provider_arn}"
        }
      },
      "service_accounts": {
        "arbitrary_name": {
          "name": "*:*"
        }
      }
    },
    "policies": {
      "external_policy": {
        "arn": "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
      }
    }
  },
  "version": "0.1"
}
```

---

## aws_iam_role/onyx-workflow-step-function-role

```json
{
  "disabled": false,
  "flavor": "default",
  "kind": "aws_iam_role",
  "metadata": {
    "name": "onyx-workflow-step-function-role"
  },
  "spec": {
    "irsa": {
      "oidc_providers": {
        "arbitrary_name": {
          "arn": "${kubernetes_cluster.default.out.attributes.legacy_outputs.k8s_details.oidc_provider_arn}"
        }
      },
      "service_accounts": {
        "arbitrary_name": {
          "name": "*:*"
        }
      }
    },
    "policies": {
      "external_policy": {
        "arn": "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
      }
    }
  },
  "version": "0.1"
}
```

---

# config_map

## config_map/dagster-job-config

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "dagster-job-config",
    "namespace": "dagster"
  },
  "spec": {
    "data": {
      "data1": {
        "key": "ANOMALY_RELEVANCY_PERIOD_DAYS",
        "value": "90"
      },
      "data10": {
        "key": "DAGSTER_POSTGRES_USER",
        "value": "${blueprint.self.variables.DAGSTER_POSTGRES_USER}"
      },
      "data11": {
        "key": "DATA_HARVEST_RETRY_INTERVAL_IN_SEC",
        "value": "2"
      },
      "data12": {
        "key": "DATA_HARVEST_API_URL",
        "value": "https://${ingress.public-ingress.out.interfaces.onelens-backend_ingress-data-harvest.host}"
      },
      "data13": {
        "key": "CUR_BUCKET_NAME",
        "value": "${s3.onelens-tenants-cur.out.attributes.bucket_name}"
      },
      "data14": {
        "key": "MAX_CONCURRENT_JOBS_EXECUTION_COUNT",
        "value": "5"
      },
      "data15": {
        "key": "DAGSTER_POSTGRES_DB",
        "value": "${blueprint.self.variables.DAGSTER_POSTGRES_DB}"
      },
      "data16": {
        "key": "DAGSTER_WEBSERVER_PORT",
        "value": "3000"
      },
      "data17": {
        "key": "DATA_HARVEST_RETRY_COUNT",
        "value": "5"
      },
      "data18": {
        "key": "DAGSTER_CURRENT_IMAGE",
        "value": "${blueprint.self.variables.DAGSTER_CURRENT_IMAGE}"
      },
      "data19": {
        "key": "TENANT_PIPEPINE_DIR",
        "value": "/dagster-efs"
      },
      "data2": {
        "key": "OCULUS_TRANSFORMATION_CONCURRENCY_LIMIT",
        "value": "2"
      },
      "data20": {
        "key": "HARVESTING_CRON_SCHEDULE",
        "value": "30 4 * * *"
      },
      "data21": {
        "key": "DAGSTER_S3_GLOBAL",
        "value": "${s3.onelens-data.out.attributes.bucket_name}"
      },
      "data22": {
        "key": "GOOGLE_GEMINI_API_KEY",
        "value": "${blueprint.self.secrets.GOOGLE_GEMINI_API_KEY}"
      },
      "data23": {
        "key": "DAGSTER_POSTGRES_PASSWORD",
        "value": "${blueprint.self.secrets.DAGSTER_POSTGRES_PASSWORD}"
      },
      "data24": {
        "key": "ONELENS_BACKEND_API_SECRET_TOKEN",
        "value": "${blueprint.self.secrets.ONELENS_BACKEND_API_SECRET_TOKEN}"
      },
      "data25": {
        "key": "TEAMS_WEBHOOK_URL",
        "value": "${blueprint.self.secrets.TEAMS_WEBHOOK_URL}"
      },
      "data26": {
        "key": "ONELENS_DATA_ENVIRONMENT",
        "value": "${blueprint.self.variables.ENV}"
      },
      "data27": {
        "key": "AZURE_API_VERSION",
        "value": "${blueprint.self.variables.AZURE_API_VERSION}"
      },
      "data28": {
        "key": "AZURE_OPENAI_ENDPOINT",
        "value": "${blueprint.self.variables.AZURE_OPENAI_ENDPOINT}"
      },
      "data29": {
        "key": "REASONING_AZURE_OPENAI_API_KEY",
        "value": "${blueprint.self.secrets.REASONING_AZURE_OPENAI_API_KEY}"
      },
      "data3": {
        "key": "CUR_IMPORT_PERIOD",
        "value": "12"
      },
      "data30": {
        "key": "AZURE_OPENAI_API_KEY",
        "value": "${blueprint.self.secrets.AZURE_OPENAI_API_KEY}"
      },
      "data31": {
        "key": "DAGSTER_MAX_RUNTIME_SECONDS",
        "value": "${blueprint.self.variables.DAGSTER_MAX_RUNTIME_SECONDS}"
      },
      "data32": {
        "key": "ONYX_SECRET_TOKEN",
        "value": "${blueprint.self.secrets.ONYX_SECRET_TOKEN}"
      },
      "data33": {
        "key": "REASONING_AZURE_API_VERSION",
        "value": "${blueprint.self.variables.REASONING_AZURE_API_VERSION}"
      },
      "data34": {
        "key": "REASONING_AZURE_OPENAI_ENDPOINT",
        "value": "${blueprint.self.variables.REASONING_AZURE_OPENAI_ENDPOINT}"
      },
      "data35": {
        "key": "DAGSTER_DBT_PARSE_PROJECT_ON_LOAD",
        "value": "1"
      },
      "data36": {
        "key": "ONYX_API_URL",
        "value": "${blueprint.self.variables.ONYX_API_URL}"
      },
      "data37": {
        "key": "CUR_CLOUD_PROVIDER",
        "value": "${blueprint.self.variables.CUR_CLOUD_PROVIDER}"
      },
      "data38": {
        "key": "GCP_CUR_BUCKET_NAME",
        "value": "${google_cloud_storage.tenant-cur.out.attributes.name}"
      },
      "data39": {
        "key": "GCP_CREDENTIALS",
        "value": "${blueprint.self.secrets.GCP_CREDENTIALS}"
      },
      "data4": {
        "key": "KMS_KEY",
        "value": "${blueprint.self.secrets.KMS_KEY}"
      },
      "data40": {
        "key": "GCP_STORAGE_ACCESS_KEY",
        "value": "${blueprint.self.secrets.GCP_STORAGE_ACCESS_KEY}"
      },
      "data41": {
        "key": "GCP_STORAGE_SECRET_KEY",
        "value": "${blueprint.self.secrets.GCP_STORAGE_SECRET_KEY}"
      },
      "data42": {
        "key": "S3_INSIGHTS_AI_GATEWAY_SUBSCRIPTION_KEY",
        "value": "${blueprint.self.secrets.S3_INSIGHTS_AI_GATEWAY_SUBSCRIPTION_KEY}"
      },
      "data43": {
        "key": "ANOMALY_AI_GATEWAY_SUBSCRIPTION_KEY",
        "value": "${blueprint.self.secrets.ANOMALY_AI_GATEWAY_SUBSCRIPTION_KEY}"
      },
      "data44": {
        "key": "OL_DATA_REASONING_AZURE_OPENAI_ENDPOINT",
        "value": "${blueprint.self.variables.OL_DATA_REASONING_AZURE_OPENAI_ENDPOINT}"
      },
      "data45": {
        "key": "CUR_DELTA_QUEUE",
        "value": "${sqs.onyx-cur-delta.out.attributes.sqs_queue_name}"
      },
      "data46": {
        "key": "GLOBAL_MULTI_TENANT_FAILURE_SENSOR_TEAMS_WEBHOOK_URL",
        "value": "${blueprint.self.secrets.GLOBAL_MULTI_TENANT_FAILURE_SENSOR_TEAMS_WEBHOOK_URL}"
      },
      "data47": {
        "key": "DAGSTER_RUN_DATA_CLEANUP_CONCURRENCY_LIMIT",
        "value": "${blueprint.self.variables.DAGSTER_RUN_DATA_CLEANUP_CONCURRENCY_LIMIT}"
      },
      "data48": {
        "key": "DAGSTER_MAX_RUNTIME_SECONDS_FOR_DAGSTER_RUN_DATA_CLEANUP_JOB",
        "value": "${blueprint.self.variables.DAGSTER_MAX_RUNTIME_SECONDS_FOR_DAGSTER_RUN_DATA_CLEANUP_JOB}"
      },
      "data5": {
        "key": "DATA_HARVEST_JOB_POLL_TIME_IN_SEC",
        "value": "30"
      },
      "data6": {
        "key": "ENV",
        "value": "${blueprint.self.variables.ENV}"
      },
      "data7": {
        "key": "ONELENS_BACKEND_API_URL",
        "value": "https://${ingress.public-ingress.out.interfaces.onelens-backend_ingress-onelens-backend.host}"
      },
      "data8": {
        "key": "DAGSTER_POSTGRES_HOSTNAME",
        "value": "${blueprint.self.variables.DAGSTER_POSTGRES_HOSTNAME}"
      },
      "data9": {
        "key": "DAGSTER_WEBSERVER_HOSTNAME",
        "value": "${ingress.dagster.out.interfaces.facets_dagster-webserver.host}"
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-authentication

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-authentication",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nAPP_TITLE=\"authentication\"\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nNOTIFICATION_SETTING_DB_NAME=\"${dynamodb.onyx-workflow-settings-db.out.attributes.table_name}\"\nSSO_TENANT_MAPPING_DB_NAME=\"${dynamodb.onyx-auth-sso-tenant-mapping-db.out.attributes.table_name}\"\nINTEGRATIONS_BASE_URL=\"${service.onyx-integrations-api.out.interfaces.http.port_name}://${service.onyx-integrations-api.out.interfaces.http.host}:${service.onyx-integrations-api.out.interfaces.http.port}\"\nONELENS_BASE_URL=\"${service.onelens-backend.out.interfaces.http.port_name}://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}\"\nONYX_BASE_URL=\"https://${ingress.public-nlb-ingress.out.interfaces.onyx-app_onyx-request-processor-api.host}\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-cost-center

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-cost-center",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nAPP_TITLE=\"cost-center\"\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nNOTIFICATION_SETTING_DB_NAME=\"${dynamodb.onyx-workflow-settings-db.out.attributes.table_name}\"\nSSO_TENANT_MAPPING_DB_NAME=\"${dynamodb.onyx-auth-sso-tenant-mapping-db.out.attributes.table_name}\"\nINTEGRATIONS_BASE_URL=\"${service.onyx-integrations-api.out.interfaces.http.port_name}://${service.onyx-integrations-api.out.interfaces.http.host}:${service.onyx-integrations-api.out.interfaces.http.port}\"\nONELENS_BASE_URL=\"${service.onelens-backend.out.interfaces.http.port_name}://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}\"\nONYX_BASE_URL=\"https://${ingress.public-nlb-ingress.out.interfaces.onyx-app_onyx-request-processor-api.host}\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-dashboard

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-dashboard",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nAPP_TITLE=\"dashboard\"\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nNOTIFICATION_SETTING_DB_NAME=\"${dynamodb.onyx-workflow-settings-db.out.attributes.table_name}\"\nSSO_TENANT_MAPPING_DB_NAME=\"${dynamodb.onyx-auth-sso-tenant-mapping-db.out.attributes.table_name}\"\nINTEGRATIONS_BASE_URL=\"${service.onyx-integrations-api.out.interfaces.http.port_name}://${service.onyx-integrations-api.out.interfaces.http.host}:${service.onyx-integrations-api.out.interfaces.http.port}\"\nONELENS_BASE_URL=\"${service.onelens-backend.out.interfaces.http.port_name}://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}\"\nONYX_BASE_URL=\"https://${ingress.public-nlb-ingress.out.interfaces.onyx-app_onyx-request-processor-api.host}\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-dwh

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-dwh",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nONELENS_BASE_URL=\"${service.onelens-backend.out.interfaces.http.port_name}://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}\"\nCUR_QUERY_CONFIG_DIRECTORY_PATH=\"dataware_house/cur/infrastructure/helper/configs\"\nEXPORT_BUCKET_NAME=\"${s3.onyx-workflow.out.attributes.bucket_name}\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-integrations

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-integrations",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nAPP_TITLE=\"integrations\"\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nEXTERNAL_PROVIDER=\"truto\"\nGLOBAL_INTEGRATION_ACTION_CONFIG_DB_NAME=\"${dynamodb.onyx-global-integration-action-config-db.out.attributes.table_arn}\"\nGLOBAL_INTEGRATION_DB_NAME=\"${dynamodb.onyx-global-integration-db.out.attributes.table_name}\"\nTENANT_INTEGRATION_AUDIT_DB_NAME=\"${dynamodb.onyx-tenant-integration-audit-db.out.attributes.table_arn}\"\nTENANT_INTEGRATION_CREDENTIAL_DB_NAME=\"${dynamodb.onyx-tenant-integration-credentials-db.out.attributes.table_name}\"\nTENANT_INTEGRATION_DB_NAME=\"${dynamodb.onyx-tenant-integration-db.out.attributes.table_name}\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-request-proc

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-request-proc",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nAPP_TITLE=\"request_processor\"\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nCUSTOMER_EVENT_QUEUE_URL=\"${sqs.onyx-orchestrator.out.attributes.sqs_queue_name}\"\nEVENT_QUEUE_URL=\"${sqs.onyx-request-processor.out.attributes.queue_arn}\"\nLARGE_MESSAGE_BUCKET=\"${s3.onyx-backend.out.attributes.bucket_name}\"\nLOG_ES_HOST=\"${elasticsearch.logs.out.interfaces.http.host}\"\nLOG_ES_INDEX=\"${blueprint.self.variables.LOG_ES_INDEX}\"\nLOG_ES_REGION=\"${blueprint.self.variables.LOG_ES_REGION}\"\nLOG_QUEUE_URL=\"${sqs.onyx-log-processor.out.attributes.queue_arn}\"\nREQUEST_DB_NAME=\"${dynamodb.onyx-request-db.out.attributes.table_name}\"\nRUNBOOKS_API_URL=\"${service.onyx-runbooks-api.out.interfaces.http.port_name}://${service.onyx-runbooks-api.out.interfaces.http.host}:${service.onyx-runbooks-api.out.interfaces.http.port}\"\nTENANT_DB_NAME=\"${dynamodb.onyx-tenant-db.out.attributes.table_name}\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-scheduler

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-scheduler",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nCOST_API_URL=\"${service.onyx-dataware-house-api.out.interfaces.http.port_name}://${service.onyx-dataware-house-api.out.interfaces.http.host}:${service.onyx-dataware-house-api.out.interfaces.http.port}\"\nAPP_TITLE=\"workflow-mgmt-api\"\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nINTEGRATIONS_BASE_URL=\"${service.onyx-integrations-api.out.interfaces.http.port_name}://${service.onyx-integrations-api.out.interfaces.http.host}:${service.onyx-integrations-api.out.interfaces.http.port}\"\nONELENS_BASE_URL=\"${service.onelens-backend.out.interfaces.http.port_name}://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}\"\nTENANT_INTEGRATION_DB_NAME=\"${dynamodb.onyx-tenant-integration-db.out.attributes.table_name}\"\nTRIGGER_QUEUE_URL=\"${sqs.onyx-workflow-trigger.out.attributes.queue_arn}\"\nWORKFLOW_ACTION_EXECUTION_API=\"${ingress.public-nlb-ingress.out.interfaces.onyx-app_onyx-request-processor-api.connection_string}/api/workflow/actions\"\nWORKFLOW_AUDIT_DB_NAME=\"${dynamodb.onyx-workflow-audit-db.out.attributes.table_name}\"\nWORKFLOW_BUCKET_NAME=\"${s3.onyx-workflow.out.attributes.bucket_name}\"\nWORKFLOW_DB_NAME=\"${dynamodb.onyx-workflow-db.out.attributes.table_name}\"\nWORKFLOW_EXECUTION_DB_NAME=\"${dynamodb.onyx-workflow-execution-db.out.attributes.table_name}\"\nWORKFLOW_EXECUTION_ROLE=\"${aws_iam_role.onyx-workflow-step-function-role.out.attributes.irsa_iam_role_arn}\"\nWORKFLOW_EXECUTION_SECRET_TOKEN=\"${aws_eventbridge.onyx-workflow-execution.out.attributes.connection_name}\"\nWORKFLOW_GLOBAL_TRIGGER_DB_NAME=\"${dynamodb.onyx-workflow-global-trigger-db.out.attributes.table_name}\"\nWORKFLOW_SETTINGS_DB_NAME=\"${dynamodb.onyx-workflow-settings-db.out.attributes.table_name}\"\nWORKFLOW_TRIGGER_DB_NAME=\"${dynamodb.onyx-workflow-trigger-db.out.attributes.table_name}\"\nWORKFLOW_VERSION_DB_NAME=\"${dynamodb.onyx-workflow-version-db.out.attributes.table_name}\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-wf-actions

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-wf-actions",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nAPP_TITLE=\"workflow-actions-api\"\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nONELENS_BASE_URL=\"${service.onelens-backend.out.interfaces.http.port_name}://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}\"\nWORKFLOW_AUDIT_DB_NAME=\"${dynamodb.onyx-workflow-audit-db.out.attributes.table_name}\"\nWORKFLOW_BUCKET_NAME=\"${s3.onyx-workflow.out.attributes.bucket_name}\"\nWORKFLOW_DB_NAME=\"${dynamodb.onyx-workflow-db.out.attributes.table_name}\"\nWORKFLOW_EXECUTION_ROLE=\"${aws_iam_role.onyx-workflow-step-function-role.out.attributes.irsa_iam_role_arn}\"\nWORKFLOW_EXECUTION_SECRET_TOKEN=\"${aws_eventbridge.onyx-workflow-execution.out.attributes.connection_name}\"\nWORKFLOW_TRIGGER_DB_NAME=\"${dynamodb.onyx-workflow-trigger-db.out.attributes.table_name}\"\nWORKFLOW_VERSION_DB_NAME=\"${dynamodb.onyx-workflow-version-db.out.attributes.table_name}\"\nWORKFLOW_EXECUTION_DB_NAME=\"${dynamodb.onyx-workflow-execution-db.out.attributes.table_name}\"\nINTEGRATIONS_BASE_URL=\"${service.onyx-integrations-api.out.interfaces.http.port_name}://${service.onyx-integrations-api.out.interfaces.http.host}:${service.onyx-integrations-api.out.interfaces.http.port}\"\nWORKFLOW_MANAGEMENT_BASE_URL= \"${service.onyx-workflow-mgmt-api.out.interfaces.http.port_name}://${service.onyx-workflow-mgmt-api.out.interfaces.http.host}:${service.onyx-workflow-mgmt-api.out.interfaces.http.port}\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-wf-execution

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-wf-execution",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nCOST_API_URL=\"${service.onyx-dataware-house-api.out.interfaces.http.port_name}://${service.onyx-dataware-house-api.out.interfaces.http.host}:${service.onyx-dataware-house-api.out.interfaces.http.port}\"\nEXECUTION_DB_NAME=\"${dynamodb.onyx-workflow-execution-db.out.attributes.table_name}\"\nNOTIFICATION_TOPIC=\"${sns.onyx-workflow-trigger.out.attributes.topic_arn}\"\nOL_DOMAIN=\"https://test.onelens.cloud\"\nONELENS_BASE_URL=\"${service.onelens-backend.out.interfaces.http.port_name}://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}\"\nWORKFLOW_BUCKET_NAME=\"${s3.onyx-workflow.out.attributes.bucket_name}\"\nWORKFLOW_TRIGGER_DB_NAME=\"${dynamodb.onyx-workflow-trigger-db.out.attributes.table_name}\"\nWORKFLOW_MANAGEMENT_BASE_URL=\"${service.onyx-workflow-mgmt-api.out.interfaces.http.port_name}://${service.onyx-workflow-mgmt-api.out.interfaces.http.host}:${service.onyx-workflow-mgmt-api.out.interfaces.http.port}\"\nWORKFLOW_ACTION_BASE_URL=\"${ingress.public-nlb-ingress.out.interfaces.onyx-app_onyx-request-processor-api.connection_string}/api/workflow/actions\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/onyx-wf-mgmt

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "onyx-wf-mgmt",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nAPP_TITLE=\"workflow-mgmt-api\"\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nINTEGRATIONS_BASE_URL=\"${service.onyx-integrations-api.out.interfaces.http.port_name}://${service.onyx-integrations-api.out.interfaces.http.host}:${service.onyx-integrations-api.out.interfaces.http.port}\"\nONELENS_BASE_URL=\"${service.onelens-backend.out.interfaces.http.port_name}://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}\"\nTENANT_INTEGRATION_DB_NAME=\"${dynamodb.onyx-tenant-integration-db.out.attributes.table_name}\"\nTRIGGER_QUEUE_URL=\"${sqs.onyx-workflow-trigger.out.attributes.queue_arn}\"\nWORKFLOW_ACTION_EXECUTION_API=\"${ingress.public-nlb-ingress.out.interfaces.onyx-app_onyx-request-processor-api.connection_string}/api/workflow/actions\"\nWORKFLOW_AUDIT_DB_NAME=\"${dynamodb.onyx-workflow-audit-db.out.attributes.table_name}\"\nWORKFLOW_BUCKET_NAME=\"${s3.onyx-workflow.out.attributes.bucket_name}\"\nWORKFLOW_DB_NAME=\"${dynamodb.onyx-workflow-db.out.attributes.table_name}\"\nWORKFLOW_EXECUTION_DB_NAME=\"${dynamodb.onyx-workflow-execution-db.out.attributes.table_name}\"\nWORKFLOW_EXECUTION_ROLE=\"${aws_iam_role.onyx-workflow-step-function-role.out.attributes.irsa_iam_role_arn}\"\nWORKFLOW_EXECUTION_SECRET_TOKEN=\"${aws_eventbridge.onyx-workflow-execution.out.attributes.connection_name}\"\nWORKFLOW_GLOBAL_TRIGGER_DB_NAME=\"${dynamodb.onyx-workflow-global-trigger-db.out.attributes.table_name}\"\nWORKFLOW_SETTINGS_DB_NAME=\"${dynamodb.onyx-workflow-settings-db.out.attributes.table_name}\"\nWORKFLOW_TRIGGER_DB_NAME=\"${dynamodb.onyx-workflow-trigger-db.out.attributes.table_name}\"\nWORKFLOW_VERSION_DB_NAME=\"${dynamodb.onyx-workflow-version-db.out.attributes.table_name}\""
      }
    }
  },
  "version": "0.3"
}
```

---

## config_map/runbooks-api-config

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "config_map",
  "metadata": {
    "name": "runbooks-api-config",
    "namespace": "onyx"
  },
  "spec": {
    "data": {
      "data1": {
        "key": ".env",
        "value": "APP_PORT=80\nAPP_TITLE=\"runbooks-api\"\nAUTH0_ALGORITHMS=\"${blueprint.self.variables.AUTH0_ALGORITHMS}\"\nAUTH0_AUDIENCE=\"${blueprint.self.variables.AUTH0_API_AUDIENCE}\"\nAUTH0_DOMAIN=\"${blueprint.self.variables.AUTH0_DOMAIN}\"\nAUTH0_ISSUER=\"${blueprint.self.variables.AUTH0_ISSUER}\"\nBUCKET_NAME=\"${s3.onyx-backend.out.attributes.bucket_name}\"\nEXECUTION_ROLE=\"Onyx-Execution-Role\"\nGLOBAL_RUNBOOKS_DB_NAME=\"${dynamodb.onyx-global-runbooks-db.out.attributes.table_name}\"\nONELENS_BASE_URL=\"${service.onelens-backend.out.interfaces.http.port_name}://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}\"\nREAD_ONLY_ROLE=\"Onyx-Orchestrator-Readonly-Role\"\nREQUEST_PROCESSOR_URL=\"http://${service.onyx-request-processor-api.out.attributes.service_name}.onyx.svc.cluster.local:80\"\nRUNBOOKS_URL=\"${ingress.public-nlb-ingress.out.interfaces.onyx-app_onyx-request-processor-api.connection_string}\"\nGLOBAL_RUNBOOK_RECOMMENDATION_DB_NAME=\"${dynamodb.onyx-global-runbook-recommendation-db.out.attributes.table_name}\"\nRUNBOOK_EXECUTION_COUNTER_DB_NAME=\"${dynamodb.onyx-tenant-runbook-execution-counter-db.out.attributes.table_name}\"\nRUNBOOK_EXECUTION_DB_NAME=\"${dynamodb.onyx-tenant-runbook-execution-db.out.attributes.table_name}\"\nTENANT_RUNBOOK_ACCOUNT_MAPPING_DB_NAME=\"${dynamodb.onyx-tenant-runbook-account-mapping-db.out.attributes.table_name}\"\nTENANT_RUNBOOK_AUDIT_DB_NAME=\"${dynamodb.onyx-tenant-runbook-audit-db.out.attributes.table_name}\"\nTENANT_RUNBOOKS_DB_NAME=\"${dynamodb.onyx-tenant-runbooks-db.out.attributes.table_name}\""
      }
    }
  },
  "version": "0.3"
}
```

---

# configuration

## configuration/alb

```json
{
  "disabled": false,
  "for": "aws_alb_controller",
  "kind": "configuration",
  "metadata": {
    "name": "alb"
  },
  "spec": {},
  "ui": {
    "base_resource": true
  }
}
```

---

## configuration/cert-manager

```json
{
  "disabled": false,
  "for": "cert_manager",
  "kind": "configuration",
  "metadata": {
    "name": "cert-manager"
  },
  "spec": {},
  "ui": {
    "base_resource": true
  }
}
```

---

## configuration/cluster-autoscalar

```json
{
  "flavor": "default",
  "for": "cluster-autoscaler",
  "kind": "configuration",
  "metadata": {
    "name": "cluster-autoscalar"
  },
  "spec": {},
  "ui": {
    "base_resource": true
  },
  "version": "0.1"
}
```

---

## configuration/eks_addon

```json
{
  "advanced": {},
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "for": "eks_addon",
  "kind": "configuration",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "eks_addon"
  },
  "out": {},
  "provided": false,
  "spec": {},
  "ui": {
    "base_resource": true
  },
  "version": "0.2"
}
```

---

## configuration/prometheus

```json
{
  "for": "prometheus",
  "kind": "configuration",
  "metadata": {
    "name": "prometheus"
  },
  "spec": {
    "alertmanager": {
      "size": {
        "cpu": "50m",
        "memory": "0.25Gi"
      }
    },
    "grafana": {
      "size": {
        "cpu": "100m",
        "memory": "0.25Gi"
      }
    },
    "prometheus": {
      "size": {
        "cpu": "200m",
        "memory": "2Gi"
      }
    },
    "prometheus-operator": {
      "size": {
        "cpu": "100m",
        "memory": "0.25Gi"
      }
    },
    "pushgateway": {
      "size": {
        "cpu": "50m",
        "memory": "0.25Gi"
      }
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## configuration/vpa

```json
{
  "advanced": {},
  "disabled": false,
  "for": "vpa",
  "kind": "configuration",
  "metadata": {
    "name": "vpa"
  },
  "spec": {},
  "ui": {
    "base_resource": true
  },
  "version": "0.1"
}
```

---

## configuration/wireguard_operator

```json
{
  "advanced": {},
  "disabled": true,
  "for": "wireguard_operator",
  "kind": "configuration",
  "metadata": {
    "name": "wireguard_operator"
  },
  "spec": {},
  "ui": {
    "base_resource": true
  },
  "version": "0.1"
}
```

---

# dynamodb

## dynamodb/onyx-auth-sso-tenant-mapping-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-auth-sso-tenant-mapping-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {},
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-global-integration-action-config-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-global-integration-action-config-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "context",
        "type": "S"
      },
      "key2": {
        "name": "id",
        "type": "S"
      },
      "key3": {
        "name": "integration_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "context",
        "name": "ContextIndex"
      }
    },
    "hash_key": "integration_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-global-integration-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-global-integration-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "id",
        "type": "S"
      },
      "key2": {
        "name": "slug",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "slug",
        "name": "SlugIndex"
      }
    },
    "hash_key": "id",
    "point_in_time_recovery_enabled": true,
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-global-runbook-recommendation-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-global-runbook-recommendation-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "recommendation_id",
        "type": "S"
      },
      "key2": {
        "name": "runbook_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {},
    "hash_key": "recommendation_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "runbook_id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-global-runbooks-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-global-runbooks-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "id",
        "type": "S"
      },
      "key2": {
        "name": "slug",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "slug",
        "name": "SlugIndex"
      }
    },
    "hash_key": "id",
    "point_in_time_recovery_enabled": true,
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-notification-rate-limit-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-notification-rate-limit-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "client_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {},
    "hash_key": "client_id",
    "point_in_time_recovery_enabled": true,
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-request-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-request-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "id",
        "type": "S"
      },
      "key2": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {},
    "hash_key": "id",
    "point_in_time_recovery_enabled": true,
    "range_key": "tenant_id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-tenant-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-tenant-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "account_id",
        "type": "S"
      },
      "key2": {
        "name": "region",
        "type": "S"
      },
      "key3": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "account_id",
        "name": "AccountRegionIndex",
        "range_key": "region"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-tenant-integration-audit-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-tenant-integration-audit-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "created_at",
        "type": "S"
      },
      "key2": {
        "name": "id",
        "type": "S"
      },
      "key3": {
        "name": "integration_id",
        "type": "S"
      },
      "key4": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "IntegrationIdIndex",
        "range_key": "integration_id"
      },
      "index2": {
        "hash_key": "tenant_id",
        "name": "CreatedAtIndex",
        "range_key": "created_at"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-tenant-integration-credentials-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-tenant-integration-credentials-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "global_integration_id",
        "type": "S"
      },
      "key2": {
        "name": "id",
        "type": "S"
      },
      "key3": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "tenant_id-global_integration_id-index",
        "range_key": "global_integration_id"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-tenant-integration-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-tenant-integration-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "global_id",
        "type": "S"
      },
      "key2": {
        "name": "slug",
        "type": "S"
      },
      "key3": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "SlugIndex",
        "range_key": "slug"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "global_id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-tenant-runbook-account-mapping-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-tenant-runbook-account-mapping-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "account_id",
        "type": "S"
      },
      "key2": {
        "name": "id",
        "type": "S"
      },
      "key3": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "IdIndex",
        "range_key": "id"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "account_id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-tenant-runbook-audit-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-tenant-runbook-audit-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "created_at",
        "type": "S"
      },
      "key2": {
        "name": "id",
        "type": "S"
      },
      "key3": {
        "name": "runbook_id",
        "type": "S"
      },
      "key4": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "RunbookIdIndex",
        "range_key": "runbook_id"
      },
      "index2": {
        "hash_key": "tenant_id",
        "name": "CreatedAtIndex",
        "range_key": "created_at"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-tenant-runbook-execution-counter-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-tenant-runbook-execution-counter-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "runbook_id",
        "type": "S"
      },
      "key2": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {},
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "runbook_id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-tenant-runbook-execution-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-tenant-runbook-execution-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "id",
        "type": "S"
      },
      "key2": {
        "name": "runbook_id",
        "type": "S"
      },
      "key3": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "RunbookIdIndex",
        "range_key": "runbook_id"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-tenant-runbooks-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-tenant-runbooks-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "id",
        "type": "S"
      },
      "key2": {
        "name": "request_processor_id",
        "type": "S"
      },
      "key3": {
        "name": "runbook_id",
        "type": "S"
      },
      "key4": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "RunbookIdIndex",
        "range_key": "runbook_id"
      },
      "index2": {
        "hash_key": "tenant_id",
        "name": "RequestProcessorIdIndex",
        "range_key": "request_processor_id"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-workflow-audit-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-workflow-audit-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "created_at",
        "type": "S"
      },
      "key2": {
        "name": "id",
        "type": "S"
      },
      "key3": {
        "name": "tenant_id",
        "type": "S"
      },
      "key4": {
        "name": "workflow_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "TenantIdWorkflowIdIndex",
        "range_key": "workflow_id"
      },
      "index2": {
        "hash_key": "tenant_id",
        "name": "CreatedAtIndex",
        "range_key": "created_at"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-workflow-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-workflow-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "id",
        "type": "S"
      },
      "key2": {
        "name": "name",
        "type": "S"
      },
      "key3": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "NameIndex",
        "range_key": "name"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-workflow-execution-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-workflow-execution-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "id",
        "type": "S"
      },
      "key2": {
        "name": "tenant_id",
        "type": "S"
      },
      "key3": {
        "name": "workflow_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "TenantIdWorkflowIdIndex",
        "range_key": "workflow_id"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-workflow-global-trigger-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-workflow-global-trigger-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {},
    "hash_key": "id",
    "point_in_time_recovery_enabled": true,
    "range_key": null,
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-workflow-settings-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-workflow-settings-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "name",
        "type": "S"
      },
      "key2": {
        "name": "tenant_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {},
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "name",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-workflow-trigger-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-workflow-trigger-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "tenant_id",
        "type": "S"
      },
      "key2": {
        "name": "trigger",
        "type": "S"
      },
      "key3": {
        "name": "workflow_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "tenant_id",
        "name": "TriggerIndex",
        "range_key": "trigger"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "workflow_id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

## dynamodb/onyx-workflow-version-db

```json
{
  "disabled": false,
  "flavor": "astuto-dynamodb",
  "kind": "dynamodb",
  "metadata": {
    "name": "onyx-workflow-version-db"
  },
  "spec": {
    "attributes": {
      "key1": {
        "name": "id",
        "type": "S"
      },
      "key2": {
        "name": "tenant_id",
        "type": "S"
      },
      "key3": {
        "name": "workflow_id",
        "type": "S"
      }
    },
    "billing_mode": "PAY_PER_REQUEST",
    "global_secondary_indexes": {
      "index1": {
        "hash_key": "workflow_id",
        "name": "VersionIndex",
        "range_key": "id"
      }
    },
    "hash_key": "tenant_id",
    "point_in_time_recovery_enabled": true,
    "range_key": "workflow_id",
    "stream_enabled": false,
    "tags": {
      "Application": "onyx",
      "CostCenter": "engineering",
      "CostType": "region",
      "CreatedBy": "terraform",
      "NotificationEmail": "devops@astuto.ai",
      "Project": "onyx",
      "Usage": "shared"
    }
  },
  "version": "0.1"
}
```

---

# grafana_dashboard

## grafana_dashboard/app-usage-summary

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/grafana_dashboard/grafana_dashboard.schema.json",
  "advanced": {
    "inherit_from_base": true
  },
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "app-usage-summary"
  },
  "out": {},
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "center",
                "displayMode": "auto",
                "inspect": false
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A (max)"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #B (max)"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Current Requests"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A (max) / Value #B (max)"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "displayName",
                    "value": "Max utilization over a week"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A * 1 (mean)"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A * 1 (mean) / Value #B (max)"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Avg utilization over a week"
                  },
                  {
                    "id": "unit",
                    "value": "percentunit"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Max utilization over a week"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 197
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Current Requests"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 258
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "owner_name"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 431
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 2,
          "maxDataPoints": 15000,
          "options": {
            "footer": {
              "enablePagination": true,
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": [
              {
                "desc": true,
                "displayName": "Current Requests"
              }
            ]
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(\n  (\n    label_replace(\n      (\n        rate(container_cpu_usage_seconds_total[1m])\n      )\n      * on (pod) group_left(created_by_name) kube_pod_info{created_by_kind=\"ReplicaSet\"}\n    , \"replicaset\", \"$1\", \"created_by_name\", \"(.*)\")\n    * on (replicaset) group_left(owner_name) kube_replicaset_owner\n  )\n) by (owner_name)",
              "format": "table",
              "hide": false,
              "legendFormat": "__auto",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "label_replace(kube_pod_container_resource_requests{container=~\".+\", resource=\"cpu\"}, \"owner_name\", \"$1\", \"container\", \"(.*)\")",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "B"
            }
          ],
          "title": "CPU Utilization",
          "transformations": [
            {
              "id": "filterFieldsByName",
              "options": {
                "include": {
                  "names": [
                    "owner_name",
                    "Value #A",
                    "Value #B"
                  ]
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #A",
                  "operator": "*",
                  "reducer": "sum",
                  "right": "1"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "groupBy",
              "options": {
                "fields": {
                  "Value #A": {
                    "aggregations": [
                      "max"
                    ],
                    "operation": "aggregate"
                  },
                  "Value #A * 1": {
                    "aggregations": [
                      "mean"
                    ],
                    "operation": "aggregate"
                  },
                  "Value #B": {
                    "aggregations": [
                      "max"
                    ],
                    "operation": "aggregate"
                  },
                  "owner_name": {
                    "aggregations": [],
                    "operation": "groupby"
                  }
                }
              }
            },
            {
              "id": "joinByField",
              "options": {
                "byField": "owner_name",
                "mode": "inner"
              }
            },
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #A (max)",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #B (max)"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #A * 1 (mean)",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #B (max)"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            }
          ],
          "type": "table"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "center",
                "displayMode": "auto",
                "inspect": false
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A (max)"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #B (max)"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Current Requests"
                  },
                  {
                    "id": "unit",
                    "value": "decgbytes"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A (max) / Value #B (max)"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Max utilization over a week"
                  },
                  {
                    "id": "unit",
                    "value": "percentunit"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Max utilization over a week"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 295
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Current Requests"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 255
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "% age"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 139
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A * 1 (mean)"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A * 1 (mean) / Value #B (max)"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Avg utilization over a week"
                  },
                  {
                    "id": "unit",
                    "value": "percentunit"
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 24,
            "x": 0,
            "y": 10
          },
          "id": 3,
          "maxDataPoints": 15000,
          "options": {
            "footer": {
              "enablePagination": true,
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": [
              {
                "desc": true,
                "displayName": "Current Requests"
              }
            ]
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(\n  (\n    label_replace(\n      (\n        container_memory_usage_bytes{container=~\".+\"}/(1024*1024*1024)\n      )\n      * on (pod) group_left(created_by_name) kube_pod_info{created_by_kind=\"ReplicaSet\"}\n    , \"replicaset\", \"$1\", \"created_by_name\", \"(.*)\")\n    * on (replicaset) group_left(owner_name) kube_replicaset_owner\n  )\n) by (owner_name)",
              "format": "table",
              "hide": false,
              "legendFormat": "__auto",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "label_replace(kube_pod_container_resource_requests{container=~\".+\", resource=\"memory\"}/(1024*1024*1024), \"owner_name\", \"$1\", \"container\", \"(.*)\")",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "B"
            }
          ],
          "title": "Memory Utilization",
          "transformations": [
            {
              "id": "filterFieldsByName",
              "options": {
                "include": {
                  "names": [
                    "owner_name",
                    "Value #A",
                    "Value #B"
                  ]
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #A",
                  "operator": "*",
                  "reducer": "sum",
                  "right": "1"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "groupBy",
              "options": {
                "fields": {
                  "Value #A": {
                    "aggregations": [
                      "max"
                    ],
                    "operation": "aggregate"
                  },
                  "Value #A * 1": {
                    "aggregations": [
                      "mean"
                    ],
                    "operation": "aggregate"
                  },
                  "Value #B": {
                    "aggregations": [
                      "max"
                    ],
                    "operation": "aggregate"
                  },
                  "owner_name": {
                    "aggregations": [],
                    "operation": "groupby"
                  }
                }
              }
            },
            {
              "id": "joinByField",
              "options": {
                "byField": "owner_name",
                "mode": "inner"
              }
            },
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #A (max)",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #B (max)"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #A * 1 (mean)",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #B (max)"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            }
          ],
          "type": "table"
        }
      ],
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": []
      },
      "time": {
        "from": "now-7d",
        "to": "now"
      },
      "timepicker": {
        "hidden": true
      },
      "timezone": "",
      "title": "Application Resource Usage Summary",
      "uid": "3JT0w0x296zTY5t0",
      "version": 3,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/application-dashboard

```json
{
  "advanced": {
    "inherit_from_base": true
  },
  "conditional_on_intent": "service",
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "Application-overview-dashboard"
  },
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "description": "New Application level dashboard ",
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "CPU",
                "axisPlacement": "auto",
                "axisSoftMin": 0,
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 1,
                "pointSize": 3,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "percentage",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "#EAB839",
                    "value": 70
                  },
                  {
                    "color": "red",
                    "value": 90
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "limit"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "#F2495C",
                      "mode": "fixed"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byFrameRefID",
                  "options": "A"
                },
                "properties": [
                  {
                    "id": "custom.lineStyle",
                    "value": {
                      "dash": [
                        10,
                        10
                      ],
                      "fill": "dash"
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 12,
            "x": 0,
            "y": 0
          },
          "id": 2,
          "options": {
            "legend": {
              "calcs": [
                "max"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "avg(rate(container_cpu_usage_seconds_total{namespace=~\"$namespace\",endpoint=\"https-metrics\",pod=~\"$pod\",image!=\"\", container!=\"POD\"}[2m])* 1000) ",
              "format": "time_series",
              "hide": false,
              "instant": false,
              "legendFormat": "avg-usage",
              "range": true,
              "refId": "C"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(rate(container_cpu_usage_seconds_total{namespace=~\"$namespace\",endpoint=\"https-metrics\",pod=~\"$pod\",image!=\"\", container!=\"POD\"}[2m])* 1000) ",
              "hide": false,
              "legendFormat": "max-usage",
              "range": true,
              "refId": "E"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_pod_container_resource_limits{namespace=~\"$namespace\",endpoint=\"http\",pod=~\"$pod\",container=~\"$container\",resource=\"cpu\",unit=\"core\"})*1000",
              "hide": false,
              "legendFormat": "limit",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_pod_container_resource_requests{namespace=~\"$namespace\",endpoint=\"http\",pod=~\"$pod\",container=~\"$container\",resource=\"cpu\",unit=\"core\"})*1000",
              "hide": false,
              "legendFormat": "requested",
              "range": true,
              "refId": "B"
            }
          ],
          "title": "CPU Utilisation ",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "axisSoftMin": 0,
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "percentage",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "#EAB839",
                    "value": 70
                  },
                  {
                    "color": "red",
                    "value": 90
                  }
                ]
              },
              "unit": "bytes"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byFrameRefID",
                  "options": "D"
                },
                "properties": [
                  {
                    "id": "custom.lineStyle",
                    "value": {
                      "dash": [
                        10,
                        10
                      ],
                      "fill": "dash"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "limit"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "dark-red",
                      "mode": "fixed"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "avg-usage"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "green",
                      "mode": "fixed"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "requested"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "orange",
                      "mode": "fixed"
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 12,
            "x": 12,
            "y": 0
          },
          "id": 26,
          "options": {
            "legend": {
              "calcs": [
                "max"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_pod_container_resource_requests{namespace=~\"$namespace\",endpoint=\"http\",pod=~\"$pod\",container=~\"$container\",resource=\"memory\",unit=\"byte\",container!=\"POD\"})",
              "hide": false,
              "legendFormat": "requested",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(container_memory_usage_bytes{namespace=~\"$namespace\", pod=~\"$pod\", container=~\"$container\",endpoint=\"https-metrics\",image!=\"\", container!=\"POD\"})",
              "hide": false,
              "legendFormat": "max-usage",
              "range": true,
              "refId": "C"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "avg(container_memory_usage_bytes{namespace=~\"$namespace\", pod=~\"$pod\", container=~\"$container\",endpoint=\"https-metrics\",image!=\"\", container!=\"POD\"})",
              "hide": false,
              "legendFormat": "avg-usage",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_pod_container_resource_limits{namespace=~\"$namespace\",endpoint=\"http\",pod=~\"$pod\",container=~\"$container\",resource=\"memory\",unit=\"byte\",container!=\"POD\"})",
              "hide": false,
              "legendFormat": "limit",
              "range": true,
              "refId": "D"
            }
          ],
          "title": "Memory Utilisation ",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "This gives the cpu recommendation and the cap limits for each services",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": " m"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 6,
            "w": 24,
            "x": 0,
            "y": 10
          },
          "id": 39,
          "options": {
            "colorMode": "none",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max (kube_pod_container_resource_requests{namespace=~\"$namespace\",endpoint=\"http\",pod=~\"$pod\",container=~\"$container\",resource=\"cpu\",unit=\"core\"} * 1000 )",
              "hide": false,
              "legendFormat": "Current requests",
              "range": true,
              "refId": "C"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_pod_container_resource_limits{namespace=~\"$namespace\",endpoint=\"http\",pod=~\"$pod\",container=~\"$container\",resource=\"cpu\",unit=\"core\"}*1000)",
              "hide": false,
              "legendFormat": "Current limits",
              "range": true,
              "refId": "D"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_verticalpodautoscaler_status_recommendation_containerrecommendations_target{container=\"$service\",resource=\"cpu\", namespace=\"$namespace\"} * 1000)",
              "hide": false,
              "legendFormat": "Recommended requests",
              "range": true,
              "refId": "E"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_verticalpodautoscaler_status_recommendation_containerrecommendations_upperbound{container=\"$service\", resource=\"cpu\", namespace=\"$namespace\"} * 1000)",
              "hide": false,
              "legendFormat": "Recommended limits",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "VPA - CPU recommendations",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "This gives the memory recommendation for the specific service",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "decbytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 5,
            "w": 24,
            "x": 0,
            "y": 16
          },
          "id": 41,
          "options": {
            "colorMode": "none",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_pod_container_resource_requests{namespace=~\"$namespace\",endpoint=\"http\",pod=~\"$pod\",container=~\"$container\",resource=\"memory\",unit=\"byte\",container!=\"POD\"})",
              "hide": false,
              "legendFormat": "Current requests",
              "range": true,
              "refId": "C"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_pod_container_resource_limits{namespace=~\"$namespace\",endpoint=\"http\",pod=~\"$pod\",container=~\"$container\",resource=\"memory\",unit=\"byte\",container!=\"POD\"})",
              "hide": false,
              "legendFormat": "Current limits",
              "range": true,
              "refId": "D"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_verticalpodautoscaler_status_recommendation_containerrecommendations_target{container=\"$service\", resource=\"memory\", namespace=\"$namespace\"})",
              "hide": false,
              "legendFormat": "Recommended requests",
              "range": true,
              "refId": "E"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max(kube_verticalpodautoscaler_status_recommendation_containerrecommendations_upperbound{container=\"$service\", resource=\"memory\", namespace=\"$namespace\"})",
              "hide": false,
              "legendFormat": "Recommended limits",
              "range": true,
              "refId": "F"
            }
          ],
          "title": "VPA - Memory Recommendations",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "container_cpu_cfs_throttled_seconds_total is the Total time duration the container has been throttled in seconds. container_cpu_cfs_throttled_periods_total is the Number of throttled period intervals",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "CPU (%)",
                "axisPlacement": "auto",
                "axisSoftMax": 100,
                "axisSoftMin": 0,
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "dashed"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "percentage",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "#EAB839",
                    "value": 70
                  },
                  {
                    "color": "red",
                    "value": 90
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 13,
            "w": 24,
            "x": 0,
            "y": 21
          },
          "id": 27,
          "options": {
            "legend": {
              "calcs": [
                "max",
                "mean"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": false
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "sum by (namespace,pod) ((container_cpu_cfs_throttled_periods_total{pod=~\"$service.*\", namespace=\"$namespace\"} / container_cpu_cfs_periods_total{pod=~\"$service.*\", namespace=\"$namespace\"}) * 100)",
              "hide": false,
              "legendFormat": "{{pod}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "CPU throttling",
          "transparent": true,
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "auto",
                "displayMode": "auto",
                "filterable": false,
                "inspect": false
              },
              "decimals": 0,
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "{__name__=\"kube_pod_container_status_last_terminated_reason\", container=\"teleconsult-index-service\", endpoint=\"http\", instance=\"10.101.32.42:8080\", job=\"kube-state-metrics\", namespace=\"default\", pod=\"teleconsult-index-service-67548864bc-lxrxm\", reason=\"Error\", service=\"prometheus-operator-kube-state-metrics\", uid=\"2daf5193-e912-4a0a-a7eb-e230f772774a\"}"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 232
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "{__name__=\"kube_pod_container_status_last_terminated_reason\", container=\"teleconsult-index-service\", endpoint=\"http\", instance=\"10.101.32.42:8080\", job=\"kube-state-metrics\", namespace=\"default\", pod=\"teleconsult-index-service-554d58f9f4-zbcjd\", reason=\"Error\", service=\"prometheus-operator-kube-state-metrics\", uid=\"5eed78bb-0d93-4be1-9400-c2b4901b1ac1\"}"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 244
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "{__name__=\"kube_pod_container_status_last_terminated_reason\", container=\"teleconsult-index-service\", endpoint=\"http\", instance=\"10.101.32.42:8080\", job=\"kube-state-metrics\", namespace=\"default\", pod=\"teleconsult-index-service-77dd49cb5c-4f7nt\", reason=\"Error\", service=\"prometheus-operator-kube-state-metrics\", uid=\"cc64ebdd-e4a4-4e30-95c0-4e04cf86a196\"}"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 292
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "{container=\"teleconsult-index-service\", endpoint=\"http\", instance=\"10.101.32.42:8080\", job=\"kube-state-metrics\", namespace=\"default\", pod=\"teleconsult-index-service-554d58f9f4-zbcjd\", service=\"prometheus-operator-kube-state-metrics\", uid=\"5eed78bb-0d93-4be1-9400-c2b4901b1ac1\"}"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 297
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "endpoint"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 84
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "pod"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 381
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "container"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 189
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "namespace"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 101
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "reason"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 84
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 13,
            "x": 0,
            "y": 34
          },
          "id": 37,
          "options": {
            "footer": {
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": []
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "group by (pod,namespace)(increase(kube_pod_container_status_restarts_total{namespace=~\"$namespace\",pod=~\"$pod\",container=~\"$container\"}[5m]))\u003e0",
              "hide": true,
              "instant": false,
              "legendFormat": "__auto",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "sum (kube_pod_container_status_last_terminated_reason{namespace=~\"$namespace\",pod=~\"$pod\",container=~\"$container\"}) by (pod,namespace,container,reason)",
              "hide": true,
              "legendFormat": "__auto",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "kube_pod_container_status_last_terminated_reason{namespace=~\"$namespace\",pod=~\"$pod\",container=~\"$container\"}",
              "hide": false,
              "instant": false,
              "legendFormat": "__auto",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Pod Termination ",
          "transformations": [
            {
              "id": "labelsToFields",
              "options": {
                "keepLabels": [
                  "container",
                  "namespace",
                  "pod",
                  "reason"
                ],
                "mode": "columns"
              }
            },
            {
              "id": "merge",
              "options": {}
            },
            {
              "id": "organize",
              "options": {
                "excludeByName": {
                  "Time": false,
                  "Value": true
                },
                "indexByName": {},
                "renameByName": {}
              }
            },
            {
              "id": "groupBy",
              "options": {
                "fields": {
                  "Time": {
                    "aggregations": [
                      "lastNotNull"
                    ],
                    "operation": "aggregate"
                  },
                  "container": {
                    "aggregations": [],
                    "operation": "groupby"
                  },
                  "namespace": {
                    "aggregations": [],
                    "operation": "groupby"
                  },
                  "pod": {
                    "aggregations": [],
                    "operation": "groupby"
                  },
                  "reason": {
                    "aggregations": [],
                    "operation": "groupby"
                  }
                }
              }
            }
          ],
          "type": "table"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 1,
                "pointSize": 3,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "noValue": "No scaling information",
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 10,
            "w": 11,
            "x": 13,
            "y": 34
          },
          "id": 18,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "kube_horizontalpodautoscaler_spec_max_replicas{namespace=~\"$namespace\",horizontalpodautoscaler=~\"$service\"}",
              "format": "time_series",
              "hide": true,
              "instant": false,
              "interval": "",
              "legendFormat": "max-status-{{horizontalpodautoscaler}}",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum by (horizontalpodautoscaler)(kube_horizontalpodautoscaler_status_current_replicas{namespace=~\"$namespace\",horizontalpodautoscaler=~\"$service\"})",
              "format": "time_series",
              "hide": false,
              "instant": false,
              "interval": "",
              "legendFormat": "current-status-{{horizontalpodautoscaler}}",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Pod Scaling information ",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "left",
                "displayMode": "auto",
                "inspect": false
              },
              "decimals": 0,
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "namespace"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 123
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Time"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 210
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Pod "
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 377
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Timestamp"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 162
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Count"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 83
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Container"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 244
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 9,
            "w": 13,
            "x": 0,
            "y": 44
          },
          "id": 25,
          "options": {
            "footer": {
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": []
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "round(increase(kube_pod_container_status_restarts_total{namespace=~\"$namespace\",pod=~\"$pod\",container=~\"$container\"}[5m]))\u003e0",
              "legendFormat": "Pod: {{pod}}, Container:  {{container}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Total Container Restarts ",
          "transformations": [
            {
              "id": "labelsToFields",
              "options": {
                "keepLabels": [
                  "container",
                  "namespace",
                  "pod"
                ]
              }
            },
            {
              "id": "merge",
              "options": {}
            },
            {
              "id": "organize",
              "options": {
                "excludeByName": {
                  "Time": false,
                  "Value": false
                },
                "indexByName": {},
                "renameByName": {
                  "Time": "Timestamp",
                  "Value": "Count",
                  "container": "Container",
                  "namespace": "Namespace",
                  "pod": "Pod "
                }
              }
            }
          ],
          "type": "table"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "noValue": "No data on non ready pods",
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 9,
            "w": 11,
            "x": 13,
            "y": 44
          },
          "id": 32,
          "options": {
            "legend": {
              "calcs": [
                "lastNotNull"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "sum by (pod, container, reason, namespace) (kube_pod_container_status_last_terminated_reason{reason=\"OOMKilled\", container=~\"$container\",}) * on (pod,container) group_left sum by (pod, container) (changes(kube_pod_container_status_restarts_total{}[1m]))",
              "hide": true,
              "legendFormat": "__auto",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(kube_pod_container_status_last_terminated_reason{namespace=~\"$namespace\",pod=~\"$pod\",container=~\"$container\"}[2m])",
              "hide": true,
              "legendFormat": "{{pod}}: {{reason}}",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "group(kube_pod_status_ready{namespace=~\"$namespace\",pod=~\"$pod\",condition!=\"true\"}\u003e0) by (pod,condition)",
              "hide": false,
              "legendFormat": "Pod: {{pod}} condition: {{condition}}",
              "range": true,
              "refId": "C"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "group (kube_pod_status_reason{namespace=~\"$namespace\",pod=~\"$pod\"}\u003e0) by (reason)",
              "hide": true,
              "legendFormat": "__auto",
              "range": true,
              "refId": "D"
            }
          ],
          "title": "Non Ready pods ",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "align": "auto",
                "displayMode": "auto",
                "filterable": true,
                "inspect": true
              },
              "mappings": [],
              "noValue": "No Events",
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Time"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 159
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 67
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "app"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 126
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "involved_object_name"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 320
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "involved_object_kind"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 175
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "name"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 336
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "namespace"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 95
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "reason"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 193
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "source"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 199
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "message"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 317
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "kubernetes_pod_name"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 232
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Namespace"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 147
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Message"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 558
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 20,
            "w": 24,
            "x": 0,
            "y": 53
          },
          "id": 31,
          "options": {
            "footer": {
              "enablePagination": false,
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "frameIndex": 61,
            "showHeader": true,
            "sortBy": []
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "kube_event_exporter{involved_object_kind=~\"Endpoints|HorizontalPodAutoscaler|Pod|ReplicaSet|StatefulSet|Deployment\", involved_object_name=~\"$pod\"}",
              "hide": false,
              "legendFormat": "__auto",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Application Events",
          "transformations": [
            {
              "id": "labelsToFields",
              "options": {
                "keepLabels": [
                  "reason",
                  "type",
                  "involved_object_namespace",
                  "kubernetes_namespace",
                  "involved_object_kind",
                  "involved_object_name",
                  "message",
                  "kubernetes_pod_name"
                ],
                "mode": "columns"
              }
            },
            {
              "id": "merge",
              "options": {}
            },
            {
              "disabled": true,
              "id": "joinByLabels",
              "options": {
                "join": [
                  "involved_object_kind",
                  "involved_object_name",
                  "namespace",
                  "name",
                  "reason",
                  "source",
                  "type",
                  "message"
                ],
                "value": "kubernetes_pod_name"
              }
            },
            {
              "id": "organize",
              "options": {
                "excludeByName": {
                  "Value": true,
                  "involved_object_namespace": true,
                  "kubernetes_pod_name": true
                },
                "indexByName": {},
                "renameByName": {
                  "involved_object_kind": "Kind",
                  "involved_object_name": "Name",
                  "involved_object_namespace": "",
                  "kubernetes_namespace": "Namespace",
                  "message": "Message",
                  "reason": "Reason ",
                  "type": "Type"
                }
              }
            }
          ],
          "type": "table"
        }
      ],
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": [
          {
            "allValue": ".*",
            "current": {
              "selected": false,
              "text": "default",
              "value": "default"
            },
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(kube_pod_info,namespace)",
            "hide": 0,
            "includeAll": true,
            "multi": false,
            "name": "namespace",
            "options": [],
            "query": {
              "query": "label_values(kube_pod_info,namespace)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          },
          {
            "allValue": ".*",
            "current": {
              "selected": true,
              "text": "All",
              "value": "$__all"
            },
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(kube_pod_labels{namespace=\"$namespace\"},label_app)",
            "hide": 0,
            "includeAll": true,
            "multi": false,
            "name": "service",
            "options": [],
            "query": {
              "query": "label_values(kube_pod_labels{namespace=\"$namespace\"},label_app)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          },
          {
            "allValue": "$service.*",
            "current": {
              "selected": true,
              "text": [
                "All"
              ],
              "value": [
                "$__all"
              ]
            },
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(kube_pod_labels{namespace=\"$namespace\",label_app=~\"$service\"},pod)",
            "hide": 0,
            "includeAll": true,
            "multi": true,
            "name": "pod",
            "options": [],
            "query": {
              "query": "label_values(kube_pod_labels{namespace=\"$namespace\",label_app=~\"$service\"},pod)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          },
          {
            "allValue": ".*",
            "current": {
              "selected": true,
              "text": [
                "All"
              ],
              "value": [
                "$__all"
              ]
            },
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(kube_pod_container_info{namespace=~\"$namespace\",pod=~\"$pod\"},container)",
            "hide": 0,
            "includeAll": true,
            "multi": true,
            "name": "container",
            "options": [],
            "query": {
              "query": "label_values(kube_pod_container_info{namespace=~\"$namespace\",pod=~\"$pod\"},container)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          }
        ]
      },
      "time": {
        "from": "now-15d",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "",
      "title": "Application dashboard [New]",
      "uid": "x7Q57j9xA4X11hfW",
      "version": 1,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/application-resource-summary

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/grafana_dashboard/grafana_dashboard.schema.json",
  "advanced": {
    "inherit_from_base": true
  },
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT_BOOTSTRAP",
  "metadata": {
    "name": "application-resource-summary"
  },
  "out": {},
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "auto",
                "displayMode": "auto",
                "filterable": false,
                "inspect": false
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "container"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Application"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "CPU Requested per Pod"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #B"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Memory Requested per Pod"
                  },
                  {
                    "id": "unit",
                    "value": "decgbytes"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #C"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Pod Count"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "CPUTotal"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Total CPU Requested"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "MemTotal"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 224
                  },
                  {
                    "id": "displayName",
                    "value": "Total Memory Requested"
                  },
                  {
                    "id": "unit",
                    "value": "decgbytes"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Pod Count"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 104
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #D"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 101
                  },
                  {
                    "id": "displayName",
                    "value": "CPU Recommended per pod"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #E"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Memory Recommended per pod"
                  },
                  {
                    "id": "unit",
                    "value": "decgbytes"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Recommended Memory"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 257
                  },
                  {
                    "id": "unit",
                    "value": "decgbytes"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "CPU Recommended per pod"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 216
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Memory Requested per Pod "
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 196
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Memory Recommended per pod"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 219
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 20,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 2,
          "options": {
            "footer": {
              "enablePagination": false,
              "fields": [],
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": [
              {
                "desc": true,
                "displayName": "Total Memory Requested"
              }
            ]
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "max(kube_pod_container_resource_requests{resource=\"cpu\", namespace=\"default\"} * on(pod,instance) group_left() kube_pod_info{created_by_kind=\"ReplicaSet\"}) by (container)",
              "format": "table",
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "max(kube_pod_container_resource_requests{resource=\"memory\"}/(1024*1024*1024)) by (container)",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "count(kube_pod_container_info) by (container)",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "C"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max by (container) (kube_verticalpodautoscaler_status_recommendation_containerrecommendations_target{resource=\"cpu\",unit=\"core\"})",
              "format": "table",
              "hide": false,
              "legendFormat": "__auto",
              "range": true,
              "refId": "D"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "max by (container) (kube_verticalpodautoscaler_status_recommendation_containerrecommendations_target{resource=\"memory\",unit=\"byte\"}/(1024*1024*1024))",
              "format": "table",
              "hide": false,
              "legendFormat": "__auto",
              "range": true,
              "refId": "E"
            }
          ],
          "title": "Application Resource Request Details",
          "transformations": [
            {
              "id": "joinByField",
              "options": {
                "byField": "container",
                "mode": "outer"
              }
            },
            {
              "id": "filterFieldsByName",
              "options": {
                "include": {
                  "names": [
                    "container",
                    "Value #A",
                    "Value #B",
                    "Value #C",
                    "Value #E",
                    "Value #D"
                  ]
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "alias": "CPUTotal",
                "binary": {
                  "left": "Value #A",
                  "operator": "*",
                  "reducer": "sum",
                  "right": "Value #C"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "alias": "MemTotal",
                "binary": {
                  "left": "Value #B",
                  "operator": "*",
                  "reducer": "sum",
                  "right": "Value #C"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "organize",
              "options": {
                "excludeByName": {
                  "Total Recommended CPU": true,
                  "Total Recommended Memory": true,
                  "Value #D": false,
                  "Value #E": false
                },
                "indexByName": {},
                "renameByName": {}
              }
            }
          ],
          "type": "table"
        }
      ],
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": []
      },
      "time": {
        "from": "now-1h",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "",
      "title": "Application Resource Request Details",
      "uid": "8X24682hQT2J7KFl",
      "version": 3,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/ingress-overview

```json
{
  "advanced": {
    "default": {
      "preserve_uid": true
    },
    "inherit_from_base": true
  },
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "ingress-overview"
  },
  "out": {},
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "id": 27,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "The total number of requests per second for services",
          "fieldConfig": {
            "defaults": {
              "color": {
                "fixedColor": "blue",
                "mode": "thresholds"
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "reqps"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 0
          },
          "id": 2,
          "options": {
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [],
              "fields": "",
              "values": false
            },
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "round(sum(irate(nginx_ingress_controller_requests{namespace=\"$namespace\", exported_service=~\"$services\"}[2m])), 0.001) or round(sum(irate(nginx_ingress_controller_requests{namespace=\"$namespace\", service=~\"$services\"}[2m])), 0.001)",
              "legendFormat": "{{ ingress }}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Total Request Volume",
          "type": "gauge"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "The percentile response times (P99, P90, P50) for each ingress for services",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "s"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 0
          },
          "id": 4,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "histogram_quantile(0.50, sum(rate(nginx_ingress_controller_request_duration_seconds_bucket{namespace=\"$namespace\",ingress=~\"$ingress\"}[2m])) by (le))",
              "instant": false,
              "interval": "",
              "legendFormat": "P50 {{ ingress }}",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "histogram_quantile(0.90, sum(rate(nginx_ingress_controller_request_duration_seconds_bucket{namespace=\"$namespace\", ingress=~\"$ingress\"}[2m])) by (le))",
              "hide": false,
              "legendFormat": "P90 {{ ingress }}",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "histogram_quantile(0.99, sum(rate(nginx_ingress_controller_request_duration_seconds_bucket{namespace=\"$namespace\", ingress=~\"$ingress\"}[2m])) by (le))",
              "hide": false,
              "legendFormat": "P99 {{ ingress }}",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Percentile Response Times",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "The status code count for each ingress for the services",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 8
          },
          "id": 8,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "sum(label_replace(increase(nginx_ingress_controller_requests{namespace=\"$namespace\",exported_service=~\"$services\"}[2m]), \"status_code\", \"${1}xx\", \"status\", \"(.)..\")) or sum(label_replace(increase(nginx_ingress_controller_requests{namespace=\"$namespace\",service=~\"$services\"}[2m]), \"status_code\", \"${1}xx\", \"status\", \"(.)..\")) by (status_code)",
              "hide": false,
              "legendFormat": "{{status_code}}",
              "range": true,
              "refId": "B"
            }
          ],
          "title": "Status Code Count",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "The health of the services",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "center",
                "displayMode": "color-background-solid",
                "inspect": false
              },
              "mappings": [
                {
                  "options": {
                    "0": {
                      "color": "green",
                      "index": 0,
                      "text": "HEALTHY"
                    }
                  },
                  "type": "value"
                },
                {
                  "options": {
                    "from": 1,
                    "result": {
                      "color": "red",
                      "index": 1,
                      "text": "UNHEALTHY"
                    },
                    "to": 1000000000
                  },
                  "type": "range"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "transparent",
                    "value": null
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 8
          },
          "id": 11,
          "options": {
            "footer": {
              "enablePagination": false,
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": [
              {
                "desc": true,
                "displayName": "container"
              }
            ]
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "kube_deployment_status_replicas_unavailable{namespace=\"$namespace\", deployment=~\"$services\"}",
              "format": "table",
              "instant": true,
              "legendFormat": "{{deployment}}",
              "range": false,
              "refId": "A"
            }
          ],
          "title": "Services Health",
          "transformations": [
            {
              "id": "filterFieldsByName",
              "options": {
                "include": {
                  "names": [
                    "deployment",
                    "Value"
                  ]
                }
              }
            }
          ],
          "type": "table"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "The SSL expiry for hosts in each ingress for the services",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "auto",
                "displayMode": "color-background-solid",
                "filterable": false,
                "inspect": false
              },
              "mappings": [
                {
                  "options": {
                    "from": 0,
                    "result": {
                      "color": "red",
                      "index": 0
                    },
                    "to": 7
                  },
                  "type": "range"
                },
                {
                  "options": {
                    "from": 8,
                    "result": {
                      "color": "yellow",
                      "index": 1
                    },
                    "to": 14
                  },
                  "type": "range"
                },
                {
                  "options": {
                    "from": -10000000000,
                    "result": {
                      "color": "red",
                      "index": 2
                    },
                    "to": 0
                  },
                  "type": "range"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "transparent",
                    "value": null
                  }
                ]
              },
              "unit": "days"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "common_name"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 553
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "domain"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 402
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 24,
            "x": 0,
            "y": 16
          },
          "id": 13,
          "options": {
            "footer": {
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": []
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "ssl_expiry{namespace=\"$namespace\", ingress=~\"$ingress\", domain=~\"$host\"}",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "A"
            }
          ],
          "title": "SSL Expiry",
          "transformations": [
            {
              "id": "filterFieldsByName",
              "options": {
                "include": {
                  "names": [
                    "domain",
                    "Value",
                    "common_name",
                    "ingress"
                  ]
                }
              }
            },
            {
              "id": "sortBy",
              "options": {
                "fields": {},
                "sort": [
                  {
                    "field": "Value"
                  }
                ]
              }
            },
            {
              "id": "organize",
              "options": {
                "excludeByName": {},
                "indexByName": {
                  "Value": 3,
                  "common_name": 1,
                  "domain": 2,
                  "ingress": 0
                },
                "renameByName": {}
              }
            }
          ],
          "type": "table"
        }
      ],
      "refresh": "5s",
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": [
          {
            "current": {
              "selected": true,
              "text": "default",
              "value": "default"
            },
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(kube_ingress_path, namespace)",
            "description": "The list of namespace for the ingress backend",
            "hide": 0,
            "includeAll": false,
            "label": "Namespace",
            "multi": false,
            "name": "namespace",
            "options": [],
            "query": {
              "query": "label_values(kube_ingress_path, namespace)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          },
          {
            "allValue": "",
            "current": {
              "selected": true,
              "text": [
                "All"
              ],
              "value": [
                "$__all"
              ]
            },
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(kube_ingress_path{namespace=~\"$namespace\"}, service_name)",
            "description": "The list of backends from ingresses",
            "hide": 0,
            "includeAll": true,
            "label": "Services",
            "multi": true,
            "name": "services",
            "options": [],
            "query": {
              "query": "label_values(kube_ingress_path{namespace=~\"$namespace\"}, service_name)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          },
          {
            "allValue": "",
            "current": {
              "selected": true,
              "text": [
                "All"
              ],
              "value": [
                "$__all"
              ]
            },
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(kube_ingress_path{namespace=~\"$namespace\",  service_name=~\"$services\"}, ingress)",
            "hide": 2,
            "includeAll": true,
            "label": "Ingress",
            "multi": true,
            "name": "ingress",
            "options": [],
            "query": {
              "query": "label_values(kube_ingress_path{namespace=~\"$namespace\",  service_name=~\"$services\"}, ingress)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 1,
            "type": "query"
          },
          {
            "allValue": "",
            "current": {
              "selected": true,
              "text": [
                "All"
              ],
              "value": [
                "$__all"
              ]
            },
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(kube_ingress_path{namespace=~\"$namespace\",  service_name=~\"$services\"}, host)",
            "hide": 2,
            "includeAll": true,
            "label": "host",
            "multi": true,
            "name": "host",
            "options": [],
            "query": {
              "query": "label_values(kube_ingress_path{namespace=~\"$namespace\",  service_name=~\"$services\"}, host)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 1,
            "type": "query"
          }
        ]
      },
      "time": {
        "from": "now-5m",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "",
      "title": "Ingress Overview",
      "uid": "12Y89zt57LUwgq5l",
      "version": 1,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/kafka-dashboard

```json
{
  "conditional_on_intent": "kafka",
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "kafka-dashboard"
  },
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "datasource",
              "uid": "grafana"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "description": "Kafka Cluster Metrics Dashboard",
      "editable": true,
      "fiscalYearStartMonth": 0,
      "gnetId": 14505,
      "graphTooltip": 0,
      "id": 28,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 52,
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "refId": "A"
            }
          ],
          "title": "Genral Metrics",
          "type": "row"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 10,
            "w": 4,
            "x": 0,
            "y": 1
          },
          "id": 68,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "first"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_controller_kafkacontroller_activecontrollercount_value{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Active Brokers",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "yellow",
                    "value": null
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 10,
            "w": 3,
            "x": 4,
            "y": 1
          },
          "id": 24,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_server_replicamanager_total_partitioncount_value{pod=~\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "ClusterPartitionCount",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 1
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 10,
            "w": 3,
            "x": 7,
            "y": 1
          },
          "id": 22,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_controller_kafkacontroller_offlinepartitionscount_value{pod=~\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "OfflinePartitionsCount",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 10,
            "w": 4,
            "x": 10,
            "y": 1
          },
          "id": 82,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_controller_kafkacontroller_globaltopiccount_value{pod=~\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Topic Topics Per Broker",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 10,
            "w": 5,
            "x": 14,
            "y": 1
          },
          "id": 75,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_server_brokertopicmetrics_total_messagesinpersec_oneminuterate{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Broker Message In / Minute",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 11
          },
          "id": 77,
          "options": {
            "displayMode": "basic",
            "minVizHeight": 10,
            "minVizWidth": 0,
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "showUnfilled": true
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_server_brokertopicmetrics_total_messagesinpersec_count{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Total Message In Per Broker",
          "transformations": [
            {
              "id": "seriesToColumns",
              "options": {}
            }
          ],
          "type": "bargauge"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "links": [],
              "unit": "percent"
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 9,
            "w": 12,
            "x": 0,
            "y": 18
          },
          "hiddenSeries": false,
          "id": 18,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": false,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "java_lang_operatingsystem_cpuload{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "CPUUsed(%)",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "percent",
              "label": "",
              "logBase": 1,
              "show": true
            },
            {
              "format": "percent",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "aliasColors": {
            "Buffered Memory %": "yellow",
            "Memory Used %": "red",
            "Total Memory Used %": "red",
            "{env=\"prod\", exported_env=\"prod\", host=\"3.138.123.32\", instance=\"172.31.45.27:9273\", job=\"telegraf\"}": "dark-green"
          },
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "links": [],
              "unit": "decbytes"
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 9,
            "w": 12,
            "x": 12,
            "y": 18
          },
          "hiddenSeries": false,
          "id": 16,
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": true,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "java_lang_operatingsystem_totalmemorysize{pod=\"$kafka_pods\"}",
              "format": "time_series",
              "hide": false,
              "instant": false,
              "interval": "",
              "legendFormat": "{{host}} - Total Memory Used ",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "java_lang_operatingsystem_freememorysize{pod=\"$kafka_pods\"}",
              "hide": false,
              "legendFormat": "__auto",
              "range": true,
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "MemoryUsed",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "$$hashKey": "object:2346",
              "format": "decbytes",
              "logBase": 1,
              "show": true
            },
            {
              "$$hashKey": "object:2347",
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "links": [],
              "unit": "binBps"
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 27
          },
          "hiddenSeries": false,
          "id": 79,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": false,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_server_brokertopicmetrics_total_bytesinpersec_oneminuterate{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "broker Bytes Sent by 1 Minute",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "$$hashKey": "object:2423",
              "format": "binBps",
              "logBase": 1,
              "show": true
            },
            {
              "$$hashKey": "object:2424",
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "links": []
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 27
          },
          "hiddenSeries": false,
          "id": 80,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": false,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_server_brokertopicmetrics_total_bytesoutpersec_oneminuterate{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Broker Bytes out by 1 min",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "$$hashKey": "object:2423",
              "format": "decbytes",
              "logBase": 1,
              "show": true
            },
            {
              "$$hashKey": "object:2424",
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "aliasColors": {
            "172.31.45.27:9273": "light-green"
          },
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "links": []
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 10,
            "w": 12,
            "x": 0,
            "y": 35
          },
          "hiddenSeries": false,
          "id": 48,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_server_replicafetchermanager_maxlag_value{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Cluster Lag",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "$$hashKey": "object:121",
              "format": "short",
              "logBase": 1,
              "show": true
            },
            {
              "$$hashKey": "object:122",
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "links": []
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 10,
            "w": 12,
            "x": 12,
            "y": 35
          },
          "hiddenSeries": false,
          "id": 56,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_controller_controllerchannelmanager_totalqueuesize_value{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Total Queue Size",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "$$hashKey": "object:1778",
              "format": "bytes",
              "logBase": 1,
              "show": true
            },
            {
              "$$hashKey": "object:1779",
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 45
          },
          "id": 8,
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "refId": "A"
            }
          ],
          "title": "Partition Metrics",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "links": []
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 10,
            "x": 0,
            "y": 46
          },
          "hiddenSeries": false,
          "id": 42,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": false,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_server_replicamanager_total_underreplicatedpartitions_value{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{topic}}-{{partition}}",
              "range": true,
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "UnderReplicatedPartitions by topic-partition",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "$$hashKey": "object:1990",
              "format": "short",
              "logBase": 1,
              "show": true
            },
            {
              "$$hashKey": "object:1991",
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "links": [],
              "unit": "reqps"
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 46
          },
          "hiddenSeries": false,
          "id": 54,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_server_brokertopicmetrics_total_failedproducerequestspersec_oneminuterate{pod=\"$kafka_pods\"}",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Produce Rquests Failed/Sec by [1m]",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "$$hashKey": "object:711",
              "format": "reqps",
              "logBase": 1,
              "show": true
            },
            {
              "$$hashKey": "object:712",
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "collapsed": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 54
          },
          "id": 6,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "refId": "A"
            }
          ],
          "title": "Request Metrics",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "links": []
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 55
          },
          "hiddenSeries": false,
          "id": 46,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kafka_server_brokertopicmetrics_total_totalproducerequestspersec_oneminuterate{pod=\"$kafka_pods\"}",
              "format": "time_series",
              "interval": "",
              "legendFormat": "{{host}}",
              "range": true,
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Producer Request Bytes/1 Minute",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "$$hashKey": "object:639",
              "format": "decbytes",
              "logBase": 1,
              "show": true
            },
            {
              "$$hashKey": "object:640",
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        }
      ],
      "refresh": "5s",
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": [
          {
            "current": {
              "selected": false,
              "text": "Prometheus",
              "value": "Prometheus"
            },
            "hide": 0,
            "includeAll": false,
            "label": "Datasource",
            "multi": false,
            "name": "datasource",
            "options": [],
            "query": "prometheus",
            "queryValue": "",
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "type": "datasource"
          },
          {
            "current": {
              "selected": true,
              "text": "kafka-alpha-kafka-0",
              "value": "kafka-alpha-kafka-0"
            },
            "definition": "label_values(kafka_controller_kafkacontroller_activecontrollercount_value, pod)",
            "hide": 0,
            "includeAll": false,
            "multi": false,
            "name": "kafka_pods",
            "options": [],
            "query": {
              "query": "label_values(kafka_controller_kafkacontroller_activecontrollercount_value, pod)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          }
        ]
      },
      "time": {
        "from": "now-6h",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ]
      },
      "timezone": "",
      "title": "Kafka Cluster Metrics",
      "uid": "yOH8IoQMD",
      "version": 11,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/loki

```json
{
  "advanced": {
    "inherit_from_base": true
  },
  "conditional_on_intent": "log_collector",
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "loki"
  },
  "out": {},
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "description": "",
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "id": 34,
      "links": [
        {
          "asDropdown": true,
          "icon": "external link",
          "includeVars": true,
          "keepTime": true,
          "tags": [
            "Facets",
            "loki"
          ],
          "targetBlank": false,
          "title": "Loki Dashboards",
          "type": "dashboards"
        }
      ],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "log": 2,
                  "type": "log"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 0
          },
          "id": 6,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "panels": [],
          "pluginVersion": "9.2.6",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kube_daemonset_status_desired_number_scheduled{daemonset=~\".*promtail\"} - kube_daemonset_status_number_ready{daemonset=~\".*promtail\"}",
              "legendFormat": "{{daemonset}}",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kube_deployment_status_replicas{deployment=~\".*distributor\"} - kube_deployment_status_replicas_available{deployment=~\".*distributor\"}",
              "hide": false,
              "legendFormat": "{{deployment}}",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kube_statefulset_status_replicas{statefulset=~\".*ingester\"} - kube_statefulset_status_replicas_ready{statefulset=~\".*ingester\"}",
              "hide": false,
              "legendFormat": "{{statefulset}}",
              "range": true,
              "refId": "C"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kube_deployment_status_replicas{deployment=~\".*query-frontend\"} - kube_deployment_status_replicas_available{deployment=~\".*query-frontend\"}",
              "hide": false,
              "legendFormat": "{{deployment}}",
              "range": true,
              "refId": "D"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "kube_statefulset_status_replicas{statefulset=~\".*querier\"} - kube_statefulset_status_replicas_ready{statefulset=~\".*querier\"}",
              "hide": false,
              "legendFormat": "{{statefulset}}",
              "range": true,
              "refId": "E"
            }
          ],
          "title": "Non Ready Pods",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "log": 2,
                  "type": "log"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 0
          },
          "id": 123,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "panels": [],
          "pluginVersion": "9.2.6",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "increase(kube_pod_container_status_restarts_total{container=~\"compactor|query-frontend|querier|ingester|distributor|promtail\"}[5m]) \u003e 0",
              "hide": false,
              "legendFormat": "{{pod}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Container Restarts",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "log": 2,
                  "type": "log"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 0
          },
          "id": 124,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "panels": [],
          "pluginVersion": "9.2.6",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "sum by(pod) (kube_pod_container_status_last_terminated_reason{reason=\"OOMKilled\", container=~\"compactor|query-frontend|querier|ingester|distributor|promtail\"}) \u003e 0",
              "hide": false,
              "legendFormat": "{{pod}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "OOM Killed Pods",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "log": 2,
                  "type": "log"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 70
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 7
          },
          "id": 119,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "panels": [],
          "pluginVersion": "9.2.6",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "sum(increase(container_cpu_cfs_throttled_periods_total{container=~\"promtail|distributor|ingester|querier|query-frontend\"}[5m])) by (container, pod, namespace) / sum(increase(container_cpu_cfs_periods_total{container=~\"promtail|distributor|ingester|querier|query-frontend\"}[5m])) by (container, pod, namespace) * 100 \u003e 70",
              "legendFormat": "{{pod}}",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "hide": false,
              "refId": "B"
            }
          ],
          "title": "CPU Throttling",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "log": 2,
                  "type": "log"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 70
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 7
          },
          "id": 121,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "panels": [],
          "pluginVersion": "9.2.6",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "sum(container_memory_working_set_bytes{container=~\"promtail|distributor|ingester|querier|query-frontend\"}) by (pod, container_name) / sum(container_spec_memory_limit_bytes{container=~\"promtail|distributor|ingester|querier|query-frontend\"}) by (pod, container_name) * 100 \u003e 70",
              "legendFormat": "{{pod}}",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "",
              "hide": false,
              "legendFormat": "__auto",
              "range": true,
              "refId": "B"
            }
          ],
          "title": "Memory Throttling",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "log": 2,
                  "type": "log"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "s"
            },
            "overrides": [
              {
                "__systemRef": "hideSeriesFrom",
                "matcher": {
                  "id": "byNames",
                  "options": {
                    "mode": "exclude",
                    "names": [
                      "Average"
                    ],
                    "prefix": "All except:",
                    "readOnly": true
                  }
                },
                "properties": [
                  {
                    "id": "custom.hideFrom",
                    "value": {
                      "legend": false,
                      "tooltip": false,
                      "viz": true
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 7
          },
          "id": 118,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "panels": [],
          "pluginVersion": "9.2.6",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "histogram_quantile(0.99, sum(rate(promtail_request_duration_seconds_bucket[1m])) by (le, job))",
              "legendFormat": "99th Percentile",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "histogram_quantile(0.50, sum(rate(promtail_request_duration_seconds_bucket[1m])) by (le, job))",
              "hide": false,
              "legendFormat": "50th Percentile",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "sum(rate(promtail_request_duration_seconds_sum[1m])) by (job) / sum(rate(promtail_request_duration_seconds_count[1m])) by (job)",
              "hide": false,
              "legendFormat": "Average",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Promtail Latency",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "log": 2,
                  "type": "log"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 14
          },
          "id": 122,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "panels": [],
          "pluginVersion": "9.2.6",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "increase(promtail_dropped_entries_total[1m]) \u003e 0",
              "hide": false,
              "legendFormat": "{{pod}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Log Entries Dropped",
          "type": "timeseries"
        }
      ],
      "refresh": "10s",
      "schemaVersion": 37,
      "style": "dark",
      "tags": [
        "Facets",
        "loki"
      ],
      "templating": {
        "list": [
          {
            "current": {
              "selected": false,
              "text": "Prometheus",
              "value": "Prometheus"
            },
            "hide": 0,
            "includeAll": false,
            "label": "Data Source",
            "multi": false,
            "name": "datasource",
            "options": [],
            "query": "prometheus",
            "queryValue": "",
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "type": "datasource"
          }
        ]
      },
      "time": {
        "from": "now-1h",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "5s",
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ],
        "time_options": [
          "5m",
          "15m",
          "1h",
          "6h",
          "12h",
          "24h",
          "2d",
          "7d",
          "30d"
        ]
      },
      "timezone": "utc",
      "title": "Loki",
      "uid": "userfriendly",
      "version": 1,
      "weekStart": ""
    }
  },
  "version": "latest"
}
```

---

## grafana_dashboard/node-resources

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/grafana_dashboard/grafana_dashboard.schema.json",
  "advanced": {
    "default": {
      "preserve_uid": true
    },
    "inherit_from_base": true
  },
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "node-resource-details"
  },
  "out": {},
  "provided": false,
  "spec": {
    "dashboard": {
      "__elements": {},
      "__inputs": [],
      "__requires": [
        {
          "id": "gauge",
          "name": "Gauge",
          "type": "panel",
          "version": ""
        },
        {
          "id": "grafana",
          "name": "Grafana",
          "type": "grafana",
          "version": "9.2.15"
        },
        {
          "id": "prometheus",
          "name": "Prometheus",
          "type": "datasource",
          "version": "1.0.0"
        },
        {
          "id": "table",
          "name": "Table",
          "type": "panel",
          "version": ""
        }
      ],
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "mappings": [],
              "max": 1,
              "min": 0,
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "dark-red"
                  },
                  {
                    "color": "#EAB839",
                    "value": 0.4
                  },
                  {
                    "color": "green",
                    "value": 0.6
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A / Value #B"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "displayName",
                    "value": "CPU Allocation"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #C / Value #D"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "displayName",
                    "value": "Memory Allocation"
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 6,
            "y": 0
          },
          "id": 4,
          "options": {
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_pod_container_resource_requests{resource=\"cpu\", node=\"$node\"})",
              "format": "table",
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "kube_node_status_allocatable{resource=\"cpu\", node=\"$node\"}",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_pod_container_resource_requests{resource=\"memory\", node=\"$node\"})",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "C"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "kube_node_status_allocatable{resource=\"memory\", node=\"$node\"}",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "D"
            }
          ],
          "title": "Node Summary",
          "transformations": [
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #A",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #B"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #C",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #D"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "filterFieldsByName",
              "options": {
                "include": {
                  "names": [
                    "Value #A / Value #B",
                    "Value #C / Value #D"
                  ]
                }
              }
            }
          ],
          "type": "gauge"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "center",
                "displayMode": "auto",
                "inspect": false
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "CPU Requests"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #B"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "decbytes"
                  },
                  {
                    "id": "displayName",
                    "value": "Memory Requests"
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 13,
            "w": 24,
            "x": 0,
            "y": 8
          },
          "id": 2,
          "options": {
            "footer": {
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": [
              {
                "desc": true,
                "displayName": "CPU Requests"
              }
            ]
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_pod_container_resource_requests{resource=\"cpu\", node=\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_pod_container_resource_requests{resource=\"memory\", node=\"$node\"}) by (pod)",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "B"
            }
          ],
          "title": "Panel Title",
          "transformations": [
            {
              "id": "joinByField",
              "options": {
                "byField": "pod",
                "mode": "inner"
              }
            },
            {
              "id": "filterFieldsByName",
              "options": {
                "include": {
                  "names": [
                    "pod",
                    "Value #A",
                    "Value #B"
                  ]
                }
              }
            }
          ],
          "type": "table"
        }
      ],
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": [
          {
            "current": {},
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(kube_node_info, node)",
            "description": "",
            "hide": 0,
            "includeAll": false,
            "label": "Node",
            "multi": false,
            "name": "node",
            "options": [],
            "query": {
              "query": "label_values(kube_node_info, node)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          }
        ]
      },
      "time": {
        "from": "now-6h",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "",
      "title": "Node Resource Allocation",
      "uid": "p4lLcnDIz",
      "version": 8,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/node-summary

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/grafana_dashboard/grafana_dashboard.schema.json",
  "advanced": {
    "default": {
      "preserve_uid": true
    },
    "inherit_from_base": true
  },
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "node-resource-summary"
  },
  "out": {},
  "provided": false,
  "spec": {
    "dashboard": {
      "__elements": {},
      "__inputs": [],
      "__requires": [
        {
          "id": "grafana",
          "name": "Grafana",
          "type": "grafana",
          "version": "9.2.15"
        },
        {
          "id": "prometheus",
          "name": "Prometheus",
          "type": "datasource",
          "version": "1.0.0"
        },
        {
          "id": "stat",
          "name": "Stat",
          "type": "panel",
          "version": ""
        },
        {
          "id": "table",
          "name": "Table",
          "type": "panel",
          "version": ""
        }
      ],
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Total Allocatable CPU"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #B"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Allocated CPU"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #B / Value #A"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "displayName",
                    "value": "CPU Allocation"
                  },
                  {
                    "id": "thresholds",
                    "value": {
                      "mode": "absolute",
                      "steps": [
                        {
                          "color": "red"
                        },
                        {
                          "color": "yellow",
                          "value": 0.4
                        },
                        {
                          "color": "green",
                          "value": 0.6
                        }
                      ]
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 0
          },
          "id": 4,
          "options": {
            "colorMode": "value",
            "graphMode": "area",
            "justifyMode": "center",
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "text": {
              "titleSize": 15
            },
            "textMode": "value_and_name"
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_node_status_allocatable{resource=\"cpu\"})",
              "format": "table",
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_pod_container_resource_requests{resource=\"cpu\"})",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "B"
            }
          ],
          "title": "Cluster CPU Allocation Summary",
          "transformations": [
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #B",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #A"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "organize",
              "options": {
                "excludeByName": {},
                "indexByName": {
                  "Time": 0,
                  "Value #A": 1,
                  "Value #B": 2,
                  "Value #B / Value #A": 3,
                  "Value #C": 4,
                  "Value #D": 5,
                  "Value #D / Value #C": 6
                },
                "renameByName": {}
              }
            }
          ],
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Total Allocatable Memory"
                  },
                  {
                    "id": "unit",
                    "value": "decbytes"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #B"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Allocated Memory"
                  },
                  {
                    "id": "unit",
                    "value": "decbytes"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #C"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Total Allocatable Memory"
                  },
                  {
                    "id": "unit",
                    "value": "decbytes"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #B / Value #A"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "displayName",
                    "value": "Memory Allocation"
                  },
                  {
                    "id": "thresholds",
                    "value": {
                      "mode": "absolute",
                      "steps": [
                        {
                          "color": "red"
                        },
                        {
                          "color": "yellow",
                          "value": 0.4
                        },
                        {
                          "color": "green",
                          "value": 0.6
                        }
                      ]
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 0
          },
          "id": 5,
          "options": {
            "colorMode": "value",
            "graphMode": "area",
            "justifyMode": "center",
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "text": {
              "titleSize": 15
            },
            "textMode": "value_and_name"
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_node_status_allocatable{resource=\"memory\"})",
              "format": "table",
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_pod_container_resource_requests{resource=\"memory\"})",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "B"
            }
          ],
          "title": "Cluster Memory Allocation Summary",
          "transformations": [
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #B",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #A"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "organize",
              "options": {
                "excludeByName": {},
                "indexByName": {
                  "Time": 0,
                  "Value #A": 1,
                  "Value #B": 2,
                  "Value #B / Value #A": 3,
                  "Value #C": 4,
                  "Value #D": 5,
                  "Value #D / Value #C": 6
                },
                "renameByName": {}
              }
            }
          ],
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "center",
                "displayMode": "auto",
                "inspect": false
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A / Value #C"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 200
                  },
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "displayName",
                    "value": "CPU Allocation"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #C"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 179
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "node"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 300
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #C"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Total CPU Capacity"
                  },
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #A"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Total CPU Requests"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #B"
                },
                "properties": [
                  {
                    "id": "displayName",
                    "value": "Allocatable CPU"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #D"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "decbytes"
                  },
                  {
                    "id": "displayName",
                    "value": "Memory Requests"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #E"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "decbytes"
                  },
                  {
                    "id": "displayName",
                    "value": "Allocatable Memory"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #F"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "decbytes"
                  },
                  {
                    "id": "displayName",
                    "value": "Total Memory Capacity"
                  },
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Total Memory Capacity"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 175
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value #D / Value #F"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "displayName",
                    "value": "Memory Allocation"
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "node"
                },
                "properties": [
                  {
                    "id": "links",
                    "value": [
                      {
                        "targetBlank": true,
                        "title": "",
                        "url": "/d/p4lLcnDIz/node-resource-allocation?orgId=1\u0026var-node=$${__value.raw}"
                      }
                    ]
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 12,
            "w": 24,
            "x": 0,
            "y": 8
          },
          "id": 2,
          "options": {
            "footer": {
              "enablePagination": true,
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": []
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_pod_container_resource_requests{resource=\"cpu\"}) by (node)",
              "format": "table",
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "kube_node_status_allocatable{resource=\"cpu\"}",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "kube_node_status_allocatable{resource=\"cpu\"}",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "C"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "sum(kube_pod_container_resource_requests{resource=\"memory\"}) by (node)",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "D"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "kube_node_status_allocatable{resource=\"memory\"}",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "E"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "kube_node_status_allocatable{resource=\"memory\"}",
              "format": "table",
              "hide": false,
              "instant": true,
              "legendFormat": "__auto",
              "range": false,
              "refId": "F"
            }
          ],
          "title": "Node Resource Allocation",
          "transformations": [
            {
              "id": "joinByField",
              "options": {
                "byField": "node",
                "mode": "inner"
              }
            },
            {
              "id": "filterFieldsByName",
              "options": {
                "include": {
                  "names": [
                    "node",
                    "Value #A",
                    "Value #B",
                    "Value #C",
                    "Value #D",
                    "Value #E",
                    "Value #F"
                  ]
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #A",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #C"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": "Value #D",
                  "operator": "/",
                  "reducer": "sum",
                  "right": "Value #F"
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            }
          ],
          "type": "table"
        }
      ],
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": []
      },
      "time": {
        "from": "now-6h",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "",
      "title": "Node Resource Allocation Summary",
      "uid": "ntyvS7vSk",
      "version": 11,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/onyx-all-logs

```json
{
  "advanced": {
    "default": {
      "preserve_uid": true
    },
    "inherit_from_base": true
  },
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "onyx-all-logs"
  },
  "out": {},
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "id": 18,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "loki",
            "uid": "PDDCC14AE8A39CBD0"
          },
          "gridPos": {
            "h": 17,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 2,
          "options": {
            "dedupStrategy": "none",
            "enableLogDetails": true,
            "prettifyLogMessage": false,
            "showCommonLabels": false,
            "showLabels": false,
            "showTime": true,
            "sortOrder": "Descending",
            "wrapLogMessage": true
          },
          "targets": [
            {
              "datasource": {
                "type": "loki",
                "uid": "PDDCC14AE8A39CBD0"
              },
              "editorMode": "code",
              "expr": "{app=~\"onyx.*\"} |= `@timestamp` | json message=\"_entry\" | line_format `{{.message}}` | regexp `\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}.\\d+Z stdout [FP] (?P\u003cjson_content\u003e.+)` | line_format `{{.json_content}}` | json | label_format json_content=\"\" |~`$Search`",
              "queryType": "range",
              "refId": "A"
            }
          ],
          "title": "Panel Title",
          "transparent": true,
          "type": "logs"
        }
      ],
      "schemaVersion": 37,
      "style": "dark",
      "tags": [
        "Onyx"
      ],
      "templating": {
        "list": [
          {
            "current": {
              "selected": false,
              "text": "",
              "value": ""
            },
            "hide": 0,
            "name": "Search",
            "options": [
              {
                "selected": true,
                "text": "",
                "value": ""
              }
            ],
            "query": "",
            "skipUrlSync": false,
            "type": "textbox"
          }
        ]
      },
      "time": {
        "from": "now-6h",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "",
      "title": "All Logs",
      "uid": "w1h_vUtNz",
      "version": 2,
      "weekStart": ""
    }
  },
  "version": "latest"
}
```

---

## grafana_dashboard/postgres-dashboard

```json
{
  "advanced": {
    "inherit_from_base": true
  },
  "conditional_on_intent": "postgres",
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "postgres-dashboard"
  },
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": "-- Grafana --",
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "type": "dashboard"
          }
        ]
      },
      "description": "Dashboard for postgres_exporter prometheus metrics",
      "editable": true,
      "gnetId": 9628,
      "graphTooltip": 0,
      "id": null,
      "iteration": 1547234558060,
      "links": [],
      "panels": [
        {
          "collapsed": false,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 34,
          "panels": [],
          "title": "General Counters, CPU, Memory and File Descriptor Stats",
          "type": "row"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": true,
          "colors": [
            "#299c46",
            "#7eb26d",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "none",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 2,
            "w": 4,
            "x": 0,
            "y": 1
          },
          "id": 36,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_static{release=\"$release\", instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{short_version}}",
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Version",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "name"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "description": "start time of the process",
          "format": "dateTimeFromNow",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 2,
            "w": 4,
            "x": 4,
            "y": 1
          },
          "id": 28,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "110%",
          "prefix": "",
          "prefixFontSize": "110%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "process_start_time_seconds{release=\"$release\", instance=\"$instance\"} * 1000",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Start Time",
          "type": "singlestat",
          "valueFontSize": "110%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "avg"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "decbytes",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 2,
            "w": 4,
            "x": 8,
            "y": 1
          },
          "height": "200px",
          "id": 10,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "SUM(pg_stat_database_tup_fetched{datname=~\"$datname\", instance=~\"$instance\"})",
              "format": "time_series",
              "intervalFactor": 2,
              "refId": "A",
              "step": 4
            }
          ],
          "thresholds": "",
          "title": "Current fetch data",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "decbytes",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 2,
            "w": 4,
            "x": 12,
            "y": 1
          },
          "height": "200px",
          "id": 11,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "SUM(pg_stat_database_tup_inserted{release=\"$release\", datname=~\"$datname\", instance=~\"$instance\"})",
              "format": "time_series",
              "intervalFactor": 2,
              "refId": "A",
              "step": 4
            }
          ],
          "thresholds": "",
          "title": "Current insert data",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "decbytes",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 2,
            "w": 4,
            "x": 16,
            "y": 1
          },
          "height": "200px",
          "id": 12,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "SUM(pg_stat_database_tup_updated{datname=~\"$datname\", instance=~\"$instance\"})",
              "format": "time_series",
              "intervalFactor": 2,
              "refId": "A",
              "step": 4
            }
          ],
          "thresholds": "",
          "title": "Current update data",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "none",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 2,
            "w": 4,
            "x": 20,
            "y": 1
          },
          "id": 38,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_max_connections{release=\"$release\", instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Max Connections",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "avg"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "description": "Average user and system CPU time spent in seconds.",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 3
          },
          "id": 22,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "avg(rate(process_cpu_seconds_total{release=\"$release\", instance=\"$instance\"}[5m]) * 1000)",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "CPU Time",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Average CPU Usage",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "s",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "description": "Virtual and Resident memory size in bytes, averages over 5 min interval",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 3
          },
          "id": 24,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "avg(rate(process_resident_memory_bytes{release=\"$release\", instance=\"$instance\"}[5m]))",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "Resident Mem",
              "refId": "A"
            },
            {
              "expr": "avg(rate(process_virtual_memory_bytes{release=\"$release\", instance=\"$instance\"}[5m]))",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "Virtual Mem",
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Average Memory Usage",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": null,
              "format": "decbytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "description": "Number of open file descriptors",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 3
          },
          "id": 26,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "process_open_fds{release=\"$release\", instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "Open FD",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Open File Descriptors",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": null,
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "collapsed": false,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 10
          },
          "id": 32,
          "panels": [],
          "title": "Settings",
          "type": "row"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "bytes",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 3,
            "w": 3,
            "x": 0,
            "y": 11
          },
          "id": 40,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_shared_buffers_bytes{instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Shared Buffers",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "bytes",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 3,
            "w": 3,
            "x": 3,
            "y": 11
          },
          "id": 42,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_effective_cache_size_bytes{instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Effective Cache",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "bytes",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 3,
            "w": 3,
            "x": 6,
            "y": 11
          },
          "id": 44,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_maintenance_work_mem_bytes{instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Maintenance Work Mem",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "bytes",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 3,
            "w": 3,
            "x": 9,
            "y": 11
          },
          "id": 46,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_work_mem_bytes{instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Work Mem",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "decimals": 1,
          "format": "bytes",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 3,
            "w": 3,
            "x": 12,
            "y": 11
          },
          "id": 48,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_max_wal_size_bytes{instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Max WAL Size",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "none",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 3,
            "w": 3,
            "x": 15,
            "y": 11
          },
          "id": 50,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_random_page_cost{instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Random Page Cost",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "none",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 3,
            "w": 2,
            "x": 18,
            "y": 11
          },
          "id": 52,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_seq_page_cost",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Seq Page Cost",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "none",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 3,
            "w": 2,
            "x": 20,
            "y": 11
          },
          "id": 54,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_max_worker_processes{instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Max Worker Processes",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "avg"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "#299c46",
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "format": "none",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 3,
            "w": 2,
            "x": 22,
            "y": 11
          },
          "id": 56,
          "interval": null,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": false
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "pg_settings_max_parallel_workers{instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": "",
          "title": "Max Parallel Workers",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "collapsed": false,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 14
          },
          "id": 30,
          "panels": [],
          "title": "Database Stats",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 15
          },
          "id": 1,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": false,
            "rightSide": true,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": false,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 3,
          "points": true,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "pg_stat_activity_count{datname=~\"$datname\", instance=~\"$instance\", state=\"active\"} !=0",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{datname}}, s: {{state}}",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Active sessions",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": 0,
              "format": "none",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 15
          },
          "id": 60,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": true,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "irate(pg_stat_database_xact_commit{instance=\"$instance\", datname=~\"$datname\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{datname}} commits",
              "refId": "A"
            },
            {
              "expr": "irate(pg_stat_database_xact_rollback{instance=\"$instance\", datname=~\"$datname\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{datname}} rollbacks",
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Transactions",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 15
          },
          "id": 8,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sideWidth": null,
            "sort": "current",
            "sortDesc": true,
            "total": true,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "pg_stat_database_tup_updated{datname=~\"$datname\", instance=~\"$instance\"} != 0",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{datname}}",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Update data",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 22
          },
          "id": 5,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": true,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "pg_stat_database_tup_fetched{datname=~\"$datname\", instance=~\"$instance\"} != 0",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{datname}}",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Fetch data (SELECT)",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 22
          },
          "id": 6,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": true,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "pg_stat_database_tup_inserted{datname=~\"$datname\", instance=~\"$instance\"} != 0",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{datname}}",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Insert data",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "decimals": 0,
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 22
          },
          "id": 3,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "hideEmpty": false,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": true,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "pg_locks_count{datname=~\"$datname\", instance=~\"$instance\", mode=~\"$mode\"} != 0",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{datname}},{{mode}}",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Lock tables",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": 0,
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": "0",
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 29
          },
          "id": 14,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sort": "total",
            "sortDesc": true,
            "total": true,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "pg_stat_database_tup_returned{datname=~\"$datname\", instance=~\"$instance\"} != 0",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{datname}}",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Return data",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 29
          },
          "id": 4,
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": true,
            "max": true,
            "min": false,
            "rightSide": true,
            "show": true,
            "sort": "current",
            "sortDesc": false,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "pg_stat_activity_count{datname=~\"$datname\", instance=~\"$instance\", state=~\"idle|idle in transaction|idle in transaction (aborted)\"}",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{datname}}, s: {{state}}",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Idle sessions",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": "0",
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 29
          },
          "id": 7,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": true,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "pg_stat_database_tup_deleted{datname=~\"$datname\", instance=~\"$instance\"} != 0",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{datname}}",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Delete data",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "decimals": 2,
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 36
          },
          "id": 62,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "pg_stat_database_blks_hit{instance=\"$instance\", datname=~\"$datname\"} / (pg_stat_database_blks_read{instance=\"$instance\", datname=~\"$datname\"} + pg_stat_database_blks_hit{instance=\"$instance\", datname=~\"$datname\"})",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{ datname }}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Cache Hit Rate",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": 4,
              "format": "percentunit",
              "label": "",
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 36
          },
          "id": 64,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "irate(pg_stat_bgwriter_buffers_backend{instance=\"$instance\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "buffers_backend",
              "refId": "A"
            },
            {
              "expr": "irate(pg_stat_bgwriter_buffers_alloc{instance=\"$instance\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "buffers_alloc",
              "refId": "B"
            },
            {
              "expr": "irate(pg_stat_bgwriter_buffers_backend_fsync{instance=\"$instance\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "backend_fsync",
              "refId": "C"
            },
            {
              "expr": "irate(pg_stat_bgwriter_buffers_checkpoint{instance=\"$instance\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "buffers_checkpoint",
              "refId": "D"
            },
            {
              "expr": "irate(pg_stat_bgwriter_buffers_clean{instance=\"$instance\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "buffers_clean",
              "refId": "E"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Buffers (bgwriter)",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "decimals": 0,
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 36
          },
          "id": 66,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": true,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "irate(pg_stat_database_conflicts{instance=\"$instance\", datname=~\"$datname\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{datname}} conflicts",
              "refId": "B"
            },
            {
              "expr": "irate(pg_stat_database_deadlocks{instance=\"$instance\", datname=~\"$datname\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{datname}} deadlocks",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Conflicts/Deadlocks",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": "0",
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "description": "Total amount of data written to temporary files by queries in this database. All temporary files are counted, regardless of why the temporary file was created, and regardless of the log_temp_files setting.",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 43
          },
          "id": 68,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": true,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "irate(pg_stat_database_temp_bytes{instance=\"$instance\", datname=~\"$datname\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{datname}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Temp File (Bytes)",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": "0",
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 16,
            "x": 8,
            "y": 43
          },
          "id": 70,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "irate(pg_stat_bgwriter_checkpoint_write_time{instance=\"$instance\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "write_time - Total amount of time that has been spent in the portion of checkpoint processing where files are written to disk.",
              "refId": "B"
            },
            {
              "expr": "irate(pg_stat_bgwriter_checkpoint_sync_time{instance=\"$instance\"}[5m])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "sync_time - Total amount of time that has been spent in the portion of checkpoint processing where files are synchronized to disk.",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Checkpoint Stats",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "ms",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        }
      ],
      "refresh": "10s",
      "schemaVersion": 16,
      "style": "dark",
      "tags": [
        "postgres",
        "prometheus"
      ],
      "templating": {
        "list": [
          {
            "auto": true,
            "auto_count": 200,
            "auto_min": "1s",
            "current": {
              "text": "auto",
              "value": "$__auto_interval_interval"
            },
            "hide": 0,
            "label": "Interval",
            "name": "interval",
            "options": [
              {
                "selected": true,
                "text": "auto",
                "value": "$__auto_interval_interval"
              },
              {
                "selected": false,
                "text": "1s",
                "value": "1s"
              },
              {
                "selected": false,
                "text": "5s",
                "value": "5s"
              },
              {
                "selected": false,
                "text": "1m",
                "value": "1m"
              },
              {
                "selected": false,
                "text": "5m",
                "value": "5m"
              },
              {
                "selected": false,
                "text": "1h",
                "value": "1h"
              },
              {
                "selected": false,
                "text": "6h",
                "value": "6h"
              },
              {
                "selected": false,
                "text": "1d",
                "value": "1d"
              }
            ],
            "query": "1s,5s,1m,5m,1h,6h,1d",
            "refresh": 2,
            "type": "interval"
          },
          {
            "allValue": null,
            "current": {},
            "datasource": {
              "type": "prometheus"
            },
            "hide": 0,
            "includeAll": false,
            "label": "Namespace",
            "multi": false,
            "name": "namespace",
            "options": [],
            "query": "query_result(pg_exporter_last_scrape_duration_seconds)",
            "refresh": 2,
            "regex": "/.*kubernetes_namespace=\"([^\"]+).*/",
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": null,
            "current": {},
            "datasource": {
              "type": "prometheus"
            },
            "hide": 0,
            "includeAll": false,
            "label": "Release",
            "multi": false,
            "name": "release",
            "options": [],
            "query": "query_result(pg_exporter_last_scrape_duration_seconds{kubernetes_namespace=\"$namespace\"})",
            "refresh": 2,
            "regex": "/.*release=\"([^\"]+)/",
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": null,
            "current": {},
            "datasource": {
              "type": "prometheus"
            },
            "hide": 0,
            "includeAll": false,
            "label": "Instance",
            "multi": false,
            "name": "instance",
            "options": [],
            "query": "query_result(up{release=\"$release\"})",
            "refresh": 1,
            "regex": "/.*instance=\"([^\"]+).*/",
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": null,
            "current": {},
            "datasource": {
              "type": "prometheus"
            },
            "hide": 0,
            "includeAll": true,
            "label": "Database",
            "multi": true,
            "name": "datname",
            "options": [],
            "query": "label_values(datname)",
            "refresh": 1,
            "regex": "",
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": null,
            "current": {},
            "datasource": {
              "type": "prometheus"
            },
            "hide": 0,
            "includeAll": true,
            "label": "Lock table",
            "multi": true,
            "name": "mode",
            "options": [],
            "query": "label_values({mode=~\"accessexclusivelock|accesssharelock|exclusivelock|rowexclusivelock|rowsharelock|sharelock|sharerowexclusivelock|shareupdateexclusivelock\"}, mode)",
            "refresh": 1,
            "regex": "",
            "sort": 0,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          }
        ]
      },
      "time": {
        "from": "now-24h",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "5s",
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ],
        "time_options": [
          "5m",
          "15m",
          "1h",
          "6h",
          "12h",
          "24h",
          "2d",
          "7d",
          "30d"
        ]
      },
      "timezone": "browser",
      "title": "PostgresSQL Database Dashboard",
      "uid": "000000039",
      "variables": {
        "list": []
      },
      "version": 1
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/quick-log-search

```json
{
  "advanced": {
    "inherit_from_base": true
  },
  "conditional_on_intent": "log_collector",
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "quick-log-search"
  },
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": "-- Grafana --",
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "type": "dashboard"
          }
        ]
      },
      "description": "Loki logs panel with loki variables ",
      "editable": true,
      "gnetId": 12019,
      "graphTooltip": 0,
      "id": 21,
      "iteration": 1665738745432,
      "links": [],
      "panels": [
        {
          "aliasColors": {},
          "bars": true,
          "dashLength": 10,
          "dashes": false,
          "datasource": "$loki_datasource",
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 3,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "hiddenSeries": false,
          "id": 6,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": false,
            "total": false,
            "values": false
          },
          "lines": false,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum(count_over_time({namespace=\"$namespace\", app=~\"$app\"} |~ \"$search\"[$__interval]))",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "datasource": "$loki_datasource",
          "gridPos": {
            "h": 25,
            "w": 24,
            "x": 0,
            "y": 3
          },
          "id": 2,
          "maxDataPoints": "",
          "options": {
            "showLabels": false,
            "showTime": true,
            "sortOrder": "Descending",
            "wrapLogMessage": true
          },
          "targets": [
            {
              "expr": "{namespace=\"$namespace\", app=~\"$app\"} |~ \"$search\"",
              "refId": "A"
            }
          ],
          "timeFrom": null,
          "timeShift": null,
          "title": "Logs Panel",
          "type": "logs"
        },
        {
          "content": "\u003cdiv style=\"text-align:center\"\u003e For Grafana Loki blog example \u003c/div\u003e\n\n\n",
          "datasource": null,
          "gridPos": {
            "h": 3,
            "w": 24,
            "x": 0,
            "y": 28
          },
          "id": 4,
          "mode": "html",
          "timeFrom": null,
          "timeShift": null,
          "title": "",
          "transparent": true,
          "type": "text"
        }
      ],
      "refresh": "30s",
      "schemaVersion": 22,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": [
          {
            "hide": 0,
            "label": null,
            "name": "loki_datasource",
            "options": [],
            "query": "loki",
            "refresh": 1,
            "regex": "",
            "type": "datasource"
          },
          {
            "allValue": null,
            "current": {
              "text": "loki",
              "value": "loki"
            },
            "datasource": "$loki_datasource",
            "definition": "Namespace",
            "hide": 0,
            "includeAll": false,
            "index": -1,
            "label": null,
            "multi": false,
            "name": "namespace",
            "options": [],
            "query": {
              "label": "namespace"
            },
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": ".*",
            "current": {
              "text": "All",
              "value": [
                "$__all"
              ]
            },
            "datasource": "$loki_datasource",
            "definition": "App",
            "hide": 0,
            "includeAll": true,
            "index": -1,
            "label": null,
            "multi": true,
            "name": "app",
            "options": [],
            "query": {
              "label": "app"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "current": {
              "selected": false,
              "text": "",
              "value": ""
            },
            "hide": 0,
            "label": null,
            "name": "search",
            "options": [
              {
                "selected": false,
                "text": "",
                "value": ""
              }
            ],
            "query": "",
            "skipUrlSync": false,
            "type": "textbox"
          }
        ]
      },
      "time": {
        "from": "now-1h",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "5s",
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ]
      },
      "timezone": "",
      "title": "Quick Log Search",
      "uid": "liz0yRCZRas",
      "variables": {
        "list": []
      },
      "version": 1
    }
  },
  "version": "latest"
}
```

---

## grafana_dashboard/redis-dashboard

```json
{
  "advanced": {
    "inherit_from_base": true
  },
  "conditional_on_intent": "redis",
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "redis-dashboard"
  },
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": "-- Grafana --",
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "type": "dashboard"
          }
        ]
      },
      "description": "Redis Dashboard for Redis Server",
      "editable": true,
      "gnetId": 11835,
      "graphTooltip": 0,
      "id": null,
      "iteration": 1583145402535,
      "links": [],
      "panels": [
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "decimals": 0,
          "editable": true,
          "error": false,
          "format": "s",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 7,
            "w": 2,
            "x": 0,
            "y": 0
          },
          "id": 9,
          "interval": null,
          "isNew": true,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "options": {},
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": true
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "max(max_over_time(redis_uptime_in_seconds{instance=~\"$instance\"}[$__interval]))",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "",
              "metric": "",
              "refId": "A",
              "step": 1800
            }
          ],
          "thresholds": "",
          "title": "Uptime",
          "type": "singlestat",
          "valueFontSize": "70%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "rgba(245, 54, 54, 0.9)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(50, 172, 45, 0.97)"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "decimals": 0,
          "editable": true,
          "error": false,
          "format": "none",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": false,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 7,
            "w": 2,
            "x": 2,
            "y": 0
          },
          "hideTimeOverride": true,
          "id": 12,
          "interval": null,
          "isNew": true,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "options": {},
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": true
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "redis_connected_clients{instance=~\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "",
              "metric": "",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": "",
          "timeFrom": "1m",
          "timeShift": null,
          "title": "Clients",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "cacheTimeout": null,
          "colorBackground": false,
          "colorValue": false,
          "colors": [
            "rgba(50, 172, 45, 0.97)",
            "rgba(237, 129, 40, 0.89)",
            "rgba(245, 54, 54, 0.9)"
          ],
          "datasource": {
            "type": "prometheus"
          },
          "decimals": 0,
          "editable": true,
          "error": false,
          "format": "percent",
          "gauge": {
            "maxValue": 100,
            "minValue": 0,
            "show": true,
            "thresholdLabels": false,
            "thresholdMarkers": true
          },
          "gridPos": {
            "h": 7,
            "w": 4,
            "x": 4,
            "y": 0
          },
          "hideTimeOverride": true,
          "id": 11,
          "interval": null,
          "isNew": true,
          "links": [],
          "mappingType": 1,
          "mappingTypes": [
            {
              "name": "value to text",
              "value": 1
            },
            {
              "name": "range to text",
              "value": 2
            }
          ],
          "maxDataPoints": 100,
          "nullPointMode": "connected",
          "nullText": null,
          "options": {},
          "postfix": "",
          "postfixFontSize": "50%",
          "prefix": "",
          "prefixFontSize": "50%",
          "rangeMaps": [
            {
              "from": "null",
              "text": "N/A",
              "to": "null"
            }
          ],
          "sparkline": {
            "fillColor": "rgba(31, 118, 189, 0.18)",
            "full": false,
            "lineColor": "rgb(31, 120, 193)",
            "show": true
          },
          "tableColumn": "",
          "targets": [
            {
              "expr": "100 * (redis_memory_used_bytes{instance=~\"$instance\"}  / redis_memory_max_bytes{instance=~\"$instance\"} )",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "",
              "metric": "",
              "refId": "A",
              "step": 2
            }
          ],
          "thresholds": "80,95",
          "timeFrom": "1m",
          "timeShift": null,
          "title": "Memory Usage",
          "type": "singlestat",
          "valueFontSize": "80%",
          "valueMaps": [
            {
              "op": "=",
              "text": "N/A",
              "value": "null"
            }
          ],
          "valueName": "current"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "editable": true,
          "error": false,
          "fill": 1,
          "fillGradient": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 0
          },
          "hiddenSeries": false,
          "id": 2,
          "isNew": true,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": false,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "rate(redis_commands_processed_total{instance=~\"$instance\"}[1m])",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "",
              "metric": "A",
              "refId": "A",
              "step": 240,
              "target": ""
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Commands Executed / sec",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "decimals": 2,
          "editable": true,
          "error": false,
          "fill": 1,
          "fillGradient": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 0
          },
          "hiddenSeries": false,
          "id": 1,
          "isNew": true,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": false,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "options": {
            "dataLinks": []
          },
          "percentage": true,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "irate(redis_keyspace_hits_total{instance=~\"$instance\"}[5m])",
              "format": "time_series",
              "hide": false,
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "hits",
              "metric": "",
              "refId": "A",
              "step": 240,
              "target": ""
            },
            {
              "expr": "irate(redis_keyspace_misses_total{instance=~\"$instance\"}[5m])",
              "format": "time_series",
              "hide": false,
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "misses",
              "metric": "",
              "refId": "B",
              "step": 240,
              "target": ""
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Hits / Misses per Sec",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": "",
              "logBase": 1,
              "max": null,
              "min": 0,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {
            "max": "#BF1B00"
          },
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "editable": true,
          "error": false,
          "fill": 1,
          "fillGradient": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 7
          },
          "hiddenSeries": false,
          "id": 7,
          "isNew": true,
          "legend": {
            "avg": false,
            "current": false,
            "hideEmpty": false,
            "hideZero": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "null as zero",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "redis_memory_used_bytes{instance=~\"$instance\"} ",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "used",
              "metric": "",
              "refId": "A",
              "step": 240,
              "target": ""
            },
            {
              "expr": "redis_memory_max_bytes{instance=~\"$instance\"} ",
              "format": "time_series",
              "hide": false,
              "intervalFactor": 2,
              "legendFormat": "max",
              "refId": "B",
              "step": 240
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Total Memory Usage",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": 0,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "editable": true,
          "error": false,
          "fill": 1,
          "fillGradient": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 7
          },
          "hiddenSeries": false,
          "id": 10,
          "isNew": true,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "rate(redis_net_input_bytes_total{instance=~\"$instance\"}[5m])",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{ input }}",
              "refId": "A",
              "step": 240
            },
            {
              "expr": "rate(redis_net_output_bytes_total{instance=~\"$instance\"}[5m])",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{ output }}",
              "refId": "B",
              "step": 240
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Network I/O",
          "tooltip": {
            "msResolution": true,
            "shared": true,
            "sort": 0,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "editable": true,
          "error": false,
          "fill": 7,
          "fillGradient": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 14
          },
          "hiddenSeries": false,
          "id": 5,
          "isNew": true,
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": true,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum (redis_db_keys{instance=~\"$instance\"}) by (db)",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{ db }} ",
              "refId": "A",
              "step": 240,
              "target": ""
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Total Items per DB",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "none",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "editable": true,
          "error": false,
          "fill": 7,
          "fillGradient": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 14
          },
          "hiddenSeries": false,
          "id": 13,
          "isNew": true,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": true,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum (redis_db_keys{instance=~\"$instance\"}) - sum (redis_db_keys_expiring{instance=~\"$instance\"}) ",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "not expiring",
              "refId": "A",
              "step": 240,
              "target": ""
            },
            {
              "expr": "sum (redis_db_keys_expiring{instance=~\"$instance\"}) ",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "expiring",
              "metric": "",
              "refId": "B",
              "step": 240
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Expiring vs Not-Expiring Keys",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {
            "evicts": "#890F02",
            "memcached_items_evicted_total{instance=\"172.17.0.1:9150\",job=\"prometheus\"}": "#890F02",
            "reclaims": "#3F6833"
          },
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "editable": true,
          "error": false,
          "fill": 1,
          "fillGradient": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 21
          },
          "hiddenSeries": false,
          "id": 8,
          "isNew": true,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [
            {
              "alias": "reclaims",
              "yaxis": 2
            }
          ],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum(rate(redis_expired_keys_total{instance=~\"$instance\"}[5m])) by (instance)",
              "format": "time_series",
              "hide": false,
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "expired",
              "metric": "",
              "refId": "A",
              "step": 240,
              "target": ""
            },
            {
              "expr": "sum(rate(redis_evicted_keys_total{instance=~\"$instance\"}[5m])) by (instance)",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "evicted",
              "refId": "B",
              "step": 240
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Expired / Evicted",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "editable": true,
          "error": false,
          "fill": 8,
          "fillGradient": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 21
          },
          "hiddenSeries": false,
          "id": 14,
          "isNew": true,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": true,
          "steppedLine": false,
          "targets": [
            {
              "expr": "topk(5, irate(redis_commands_total{instance=~\"$instance\"} [1m]))",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{ cmd }}",
              "metric": "redis_command_calls_total",
              "refId": "A",
              "step": 240
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Command Calls / sec",
          "tooltip": {
            "msResolution": true,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus"
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 28
          },
          "hiddenSeries": false,
          "id": 16,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "redis_connected_clients{instance=\"$instance\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Redis connected clients",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        }
      ],
      "refresh": "30s",
      "schemaVersion": 21,
      "style": "dark",
      "tags": [
        "prometheus",
        "redis"
      ],
      "templating": {
        "list": [
          {
            "current": {
              "text": "Prometheus",
              "value": "Prometheus"
            },
            "hide": 0,
            "includeAll": false,
            "label": "Prometheus",
            "multi": false,
            "name": "DS_PROMETHEUS",
            "options": [],
            "query": "prometheus",
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "type": "datasource"
          },
          {
            "allValue": null,
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "label_values(redis_up, namespace)",
            "hide": 0,
            "includeAll": false,
            "label": "Namespace",
            "multi": false,
            "name": "namespace",
            "options": [],
            "query": "label_values(redis_up, namespace)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": null,
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "label_values(redis_up{namespace=\"$namespace\"}, pod)",
            "hide": 0,
            "includeAll": false,
            "label": "Pod Name",
            "multi": false,
            "name": "pod_name",
            "options": [],
            "query": "label_values(redis_up{namespace=\"$namespace\"}, pod)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": null,
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "label_values(redis_up{namespace=\"$namespace\", pod=\"$pod_name\"}, instance)",
            "hide": 0,
            "includeAll": false,
            "label": null,
            "multi": false,
            "name": "instance",
            "options": [],
            "query": "label_values(redis_up{namespace=\"$namespace\", pod=\"$pod_name\"}, instance)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          }
        ]
      },
      "time": {
        "from": "now-24h",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "5s",
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ],
        "time_options": [
          "5m",
          "15m",
          "1h",
          "6h",
          "12h",
          "24h",
          "2d",
          "7d",
          "30d"
        ]
      },
      "timezone": "browser",
      "title": "Redis Dashboard",
      "uid": "xDLNRKUWz",
      "version": 1
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/status-checks

```json
{
  "advanced": {
    "inherit_from_base": true
  },
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "status-checks"
  },
  "out": {},
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "datasource",
              "uid": "grafana"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "id": 24,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "auto",
                "displayMode": "color-background-solid",
                "filterable": true,
                "inspect": true,
                "minWidth": 50
              },
              "mappings": [
                {
                  "options": {
                    "0": {
                      "color": "dark-red",
                      "index": 1,
                      "text": "Unhealthy"
                    },
                    "1": {
                      "color": "dark-green",
                      "index": 0,
                      "text": "Healthy"
                    }
                  },
                  "type": "value"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "transparent",
                    "value": null
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 20,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 12,
          "options": {
            "footer": {
              "enablePagination": true,
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": []
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "facets_uptime_check\n",
              "format": "table",
              "instant": true,
              "legendFormat": "{{check}}",
              "range": false,
              "refId": "A"
            }
          ],
          "title": "Health Checks Status",
          "transformations": [
            {
              "id": "filterFieldsByName",
              "options": {
                "include": {
                  "names": [
                    "Value",
                    "check_name",
                    "check_namespace",
                    "check_type",
                    "last_successful_runtime",
                    "last_successful_run_duration",
                    "message"
                  ]
                }
              }
            }
          ],
          "type": "table"
        }
      ],
      "refresh": "5s",
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": []
      },
      "time": {
        "from": "now-5m",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "5s",
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ],
        "time_options": [
          "5m",
          "15m",
          "1h",
          "6h",
          "12h",
          "24h",
          "2d",
          "7d",
          "30d"
        ]
      },
      "timezone": "browser",
      "title": "Status Check Monitoring",
      "uid": "2u6ixlZdiL8ZI66x",
      "version": 1,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/unattached-volumes

```json
{
  "advanced": {
    "default": {
      "preserve_uid": true
    },
    "inherit_from_base": true
  },
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "unattached-volumes"
  },
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "id": 27,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "custom": {
                "align": "auto",
                "displayMode": "auto",
                "filterable": false,
                "inspect": false,
                "width": 20
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "__name__"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Time"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 178
                  },
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "availability_zone"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 224
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "cluster_name"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": false
                  },
                  {
                    "id": "custom.width",
                    "value": 330
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "container"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "facets_tags"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 371
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "endpoint"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "instance"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Value"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "pod"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "job"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "service"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "namespace"
                },
                "properties": [
                  {
                    "id": "custom.hidden",
                    "value": true
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "volume_id"
                },
                "properties": [
                  {
                    "id": "custom.width",
                    "value": 424
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 20,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 2,
          "interval": "2m",
          "options": {
            "footer": {
              "fields": "",
              "reducer": [
                "sum"
              ],
              "show": false
            },
            "showHeader": true,
            "sortBy": []
          },
          "pluginVersion": "9.2.15",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "exemplar": false,
              "expr": "count(leaked_volume) by (volume_id,facets_tags,availability_zone,cluster_name)",
              "format": "table",
              "instant": false,
              "interval": "",
              "legendFormat": "__auto",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Unattached Volumes",
          "transformations": [
            {
              "id": "organize",
              "options": {
                "excludeByName": {},
                "indexByName": {
                  "Time": 1,
                  "Value": 13,
                  "__name__": 2,
                  "availability_zone": 3,
                  "cluster_name": 4,
                  "container": 5,
                  "endpoint": 6,
                  "facets_tags": 7,
                  "instance": 8,
                  "job": 9,
                  "namespace": 10,
                  "pod": 11,
                  "service": 12,
                  "volume_id": 0
                },
                "renameByName": {}
              }
            }
          ],
          "type": "table"
        }
      ],
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": []
      },
      "time": {
        "from": "now-20s",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "",
      "title": "Unattached Volumes",
      "uid": "3yhuLZQ4k",
      "version": 3,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

## grafana_dashboard/vm-metrics

```json
{
  "advanced": {
    "inherit_from_base": true
  },
  "conditional_on_intent": "service",
  "depends_on": [],
  "disabled": false,
  "flavor": "default",
  "kind": "grafana_dashboard",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "vm-metrics-overview-dashboard"
  },
  "provided": false,
  "spec": {
    "dashboard": {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "datasource",
              "uid": "grafana"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations \u0026 Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "description": "Basic overview of VM host metrics",
      "editable": true,
      "fiscalYearStartMonth": 0,
      "gnetId": 10180,
      "graphTooltip": 1,
      "id": 35,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "collapsed": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 42,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "refId": "A"
            }
          ],
          "title": "Host Overview",
          "type": "row"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Time since last boot",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "decimals": 0,
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "s"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 2,
            "x": 0,
            "y": 1
          },
          "id": 6,
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "colorMode": "none",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "repeat": "host",
          "repeatDirection": "v",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "node_time_seconds{Name=~\"$vm\"} - node_boot_time_seconds{ aws_autoscaling_groupName=~\"$vm\"}",
              "format": "time_series",
              "hide": false,
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Uptime | $vm",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Number of processors",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 2,
            "x": 2,
            "y": 1
          },
          "id": 2,
          "interval": "",
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "colorMode": "none",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "repeat": "host",
          "repeatDirection": "v",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "count(count(node_cpu_seconds_total{Name=~\"$vm\"}) by (cpu))",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Processors",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Amount of memory",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "decimals": 0,
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "decbytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 2,
            "x": 4,
            "y": 1
          },
          "id": 4,
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "colorMode": "none",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "repeat": "host",
          "repeatDirection": "v",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "node_memory_MemTotal_bytes{Name=~\"$vm\"}",
              "format": "time_series",
              "instant": true,
              "intervalFactor": 1,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "RAM",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "decimals": 1,
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "max": 1,
              "min": 0,
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "#299c46",
                    "value": null
                  },
                  {
                    "color": "rgba(237, 129, 40, 0.89)",
                    "value": 0.6
                  },
                  {
                    "color": "#d44a3a",
                    "value": 0.8
                  }
                ]
              },
              "unit": "percentunit"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 3,
            "x": 6,
            "y": 1
          },
          "id": 34,
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "/^Value$/",
              "values": false
            },
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "9.2.15",
          "repeat": "host",
          "repeatDirection": "v",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "1 - avg(irate(node_cpu_seconds_total{Name=\"$vm\", mode=\"idle\"}[5m]))",
              "format": "time_series",
              "instant": false,
              "intervalFactor": 1,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "CPU Load",
          "type": "gauge"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "decimals": 1,
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "max": 1,
              "min": 0,
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "#299c46",
                    "value": null
                  },
                  {
                    "color": "rgba(237, 129, 40, 0.89)",
                    "value": 0.6
                  },
                  {
                    "color": "#d44a3a",
                    "value": 0.8
                  }
                ]
              },
              "unit": "percentunit"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 3,
            "x": 9,
            "y": 1
          },
          "id": 35,
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "9.2.15",
          "repeat": "host",
          "repeatDirection": "v",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "1 - node_memory_MemFree_bytes{Name=~\"$vm\"} / node_memory_MemTotal_bytes{Name=~\"$vm\"}",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Memory Use",
          "type": "gauge"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Free diskspace",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "decimals": 1,
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "max": 1,
              "min": 0,
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "#299c46",
                    "value": null
                  },
                  {
                    "color": "rgba(237, 129, 40, 0.89)",
                    "value": 0.6
                  },
                  {
                    "color": "#d44a3a",
                    "value": 0.8
                  }
                ]
              },
              "unit": "percentunit"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 3,
            "x": 12,
            "y": 1
          },
          "id": 8,
          "interval": "",
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "9.2.15",
          "repeat": "host",
          "repeatDirection": "v",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "1 - (sum(node_filesystem_free_bytes{Name=~\"$vm\"}) / sum(node_filesystem_size_bytes{Name=~\"$vm\"}))",
              "format": "time_series",
              "instant": false,
              "intervalFactor": 1,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Disk Free (Total)",
          "type": "gauge"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Network traffic in the last hour",
          "fieldConfig": {
            "defaults": {
              "color": {
                "fixedColor": "rgb(31, 120, 193)",
                "mode": "fixed"
              },
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "decbytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 2,
            "x": 15,
            "y": 1
          },
          "id": 10,
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "colorMode": "none",
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "repeat": "host",
          "repeatDirection": "v",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "sum(increase(node_network_receive_bytes_total{Name=~\"$vm\"}[24h]))",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Net IN (24h)",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Network traffic in the last hour",
          "fieldConfig": {
            "defaults": {
              "color": {
                "fixedColor": "rgb(31, 120, 193)",
                "mode": "fixed"
              },
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "decbytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 2,
            "x": 17,
            "y": 1
          },
          "id": 12,
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "colorMode": "none",
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.2.15",
          "repeat": "host",
          "repeatDirection": "v",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "sum(increase(node_network_transmit_bytes_total{Name=~\"$vm\"}[24h]))",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Net OUT (24h)",
          "type": "stat"
        },
        {
          "columns": [],
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fontSize": "100%",
          "gridPos": {
            "h": 4,
            "w": 5,
            "x": 19,
            "y": 1
          },
          "id": 37,
          "links": [],
          "repeat": "host",
          "repeatDirection": "v",
          "scroll": true,
          "showHeader": true,
          "sort": {
            "col": 0,
            "desc": true
          },
          "styles": [
            {
              "alias": "Available",
              "align": "auto",
              "colors": [
                "rgba(245, 54, 54, 0.9)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(50, 172, 45, 0.97)"
              ],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 1,
              "mappingType": 1,
              "pattern": "Value",
              "thresholds": [],
              "type": "number",
              "unit": "decbytes"
            },
            {
              "alias": "Mount",
              "align": "auto",
              "colors": [
                "rgba(245, 54, 54, 0.9)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(50, 172, 45, 0.97)"
              ],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "mappingType": 1,
              "pattern": "mountpoint",
              "thresholds": [],
              "type": "string",
              "unit": "short"
            },
            {
              "alias": "Type",
              "align": "auto",
              "colors": [
                "rgba(245, 54, 54, 0.9)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(50, 172, 45, 0.97)"
              ],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "mappingType": 1,
              "pattern": "fstype",
              "thresholds": [],
              "type": "string",
              "unit": "short"
            },
            {
              "alias": "",
              "align": "auto",
              "colors": [
                "rgba(245, 54, 54, 0.9)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(50, 172, 45, 0.97)"
              ],
              "decimals": 2,
              "pattern": "/.*/",
              "thresholds": [],
              "type": "hidden",
              "unit": "short"
            }
          ],
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "node_filesystem_free_bytes{fstype!~\"(tmpfs|rootfs).*\",Name=~\"$vm\"}",
              "format": "table",
              "instant": true,
              "intervalFactor": 1,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Disk (Free)",
          "transform": "table",
          "type": "table-old"
        },
        {
          "collapsed": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 5
          },
          "id": 26,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "refId": "A"
            }
          ],
          "title": "CPU Details",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 6,
            "w": 24,
            "x": 0,
            "y": 6
          },
          "hiddenSeries": false,
          "id": 14,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": true,
          "pluginVersion": "9.2.15",
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "repeat": "host",
          "repeatDirection": "v",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "sum by (mode) (irate(node_cpu_seconds_total{Name=~\"$vm\"}[5m]))",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "{{mode}}",
              "range": true,
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "CPU Load | $vm",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": 1,
              "format": "short",
              "logBase": 1,
              "min": "0",
              "show": true
            },
            {
              "format": "short",
              "logBase": 1,
              "show": false
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "collapsed": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 12
          },
          "id": 24,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "refId": "A"
            }
          ],
          "title": "Memory Details",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 6,
            "w": 24,
            "x": 0,
            "y": 13
          },
          "hiddenSeries": false,
          "id": 16,
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": true,
          "pluginVersion": "9.2.15",
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "repeat": "host",
          "repeatDirection": "v",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "node_memory_MemFree_bytes{Name=~\"$vm\"} \u003e 0",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "Free",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "expr": "node_memory_MemTotal_bytes{Name=~\"$vm\"} \u003e 0",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "Total",
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "expr": "node_memory_MemAvailable_bytes{Name=~\"$vm\"} \u003e 0",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "Available",
              "refId": "C"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Memory | $vm",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": 0,
              "format": "bytes",
              "label": "",
              "logBase": 1,
              "min": "0",
              "show": true
            },
            {
              "format": "short",
              "logBase": 1,
              "show": false
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "collapsed": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 19
          },
          "id": 28,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "refId": "A"
            }
          ],
          "title": "Network Details",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fill": 2,
          "fillGradient": 0,
          "gridPos": {
            "h": 6,
            "w": 14,
            "x": 0,
            "y": 20
          },
          "hiddenSeries": false,
          "id": 18,
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": false,
            "max": true,
            "min": true,
            "rightSide": true,
            "show": true,
            "sort": "min",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "repeat": "host",
          "repeatDirection": "v",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "irate(node_network_receive_bytes_total{Name=~\"$vm\",device=~\"(?i)^(ens|eth).+$\"}[5m])  \u003e 0",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "IN ({{device}})",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "expr": "- irate(node_network_transmit_bytes_total{Name=~\"$vm\",device=~\"(?i)^(ens|eth).+$\"}[5m]) \u003c 0",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "OUT ({{device}})",
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Network Traffic | $vm",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decbytes",
              "logBase": 1,
              "show": true
            },
            {
              "format": "short",
              "label": "",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fill": 2,
          "fillGradient": 0,
          "gridPos": {
            "h": 6,
            "w": 10,
            "x": 14,
            "y": 20
          },
          "hiddenSeries": false,
          "id": 43,
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": false,
            "max": true,
            "min": true,
            "rightSide": true,
            "show": true,
            "sort": "min",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "repeat": "host",
          "repeatDirection": "v",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "irate(node_network_receive_errs_total{Name=~\"$vm\",device=~\"(?i)^(ens|eth).+$\"}[5m]) + irate(node_network_receive_drop_total{Name=~\"$vm\",device=~\"(?i)^(ens|eth).+$\"}[5m])",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "Err/Drop IN ({{device}})",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "expr": "- (irate(node_network_transmit_errs_total{Name=~\"$vm\",device=~\"(?i)^(ens|eth).+$\"}[5m]) + irate(node_network_transmit_drop_total{Name=~\"$vm\",device=~\"(?i)^(ens|eth).+$\"}[5m]))",
              "format": "time_series",
              "hide": false,
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "Err/Drop OUT ({{device}})",
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Network Traffic | $vm",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": 1,
              "format": "pps",
              "label": "",
              "logBase": 1,
              "show": true
            },
            {
              "format": "short",
              "label": "",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "collapsed": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 26
          },
          "id": 22,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "refId": "A"
            }
          ],
          "title": "Disk Details | $vm",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 7,
            "w": 9,
            "x": 0,
            "y": 27
          },
          "hiddenSeries": false,
          "id": 40,
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "repeat": "host",
          "repeatDirection": "v",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "node_filesystem_free_bytes{Name=~\"$vm\",fstype!~\"(tmpfs|rootfs)\"}",
              "format": "time_series",
              "instant": false,
              "intervalFactor": 1,
              "legendFormat": "{{mountpoint}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Disk (Free) | $vm",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decbytes",
              "logBase": 1,
              "show": true
            },
            {
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 9,
            "y": 27
          },
          "hiddenSeries": false,
          "id": 30,
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": false,
            "max": true,
            "min": true,
            "rightSide": true,
            "show": true,
            "sort": "min",
            "sortDesc": false,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "repeat": "host",
          "repeatDirection": "v",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "irate(node_disk_read_bytes_total{Name=~\"$vm\"}[5m]) \u003e 0",
              "format": "time_series",
              "hide": false,
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "Read ({{device}})",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "expr": "- irate(node_disk_written_bytes_total{Name=~\"$vm\"}[5m]) \u003c 0",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "Write ({{device}})",
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Disk Activity | $vm",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decbytes",
              "logBase": 1,
              "show": true
            },
            {
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 7,
            "w": 7,
            "x": 17,
            "y": 27
          },
          "hiddenSeries": false,
          "id": 32,
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": false,
            "max": true,
            "min": true,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "9.2.15",
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "repeat": "host",
          "repeatDirection": "v",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "irate(node_disk_read_time_seconds_total{Name=~\"$vm\"}[5m]) \u003e 0",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "Read ({{device}})",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "expr": "- irate(node_disk_write_time_seconds_total{Name=~\"$vm\"}[5m]) \u003c 0",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "Write ({{device}})",
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Disk IO | $vm",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "s",
              "logBase": 1,
              "show": true
            },
            {
              "format": "short",
              "logBase": 1,
              "show": true
            }
          ],
          "yaxis": {
            "align": false
          }
        }
      ],
      "refresh": false,
      "schemaVersion": 37,
      "style": "dark",
      "tags": [
        "linux"
      ],
      "templating": {
        "list": [
          {
            "current": {
              "selected": true,
              "text": "bdoxtxsq7s-kuku-web-payments",
              "value": "bdoxtxsq7s-kuku-web-payments"
            },
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "label_values(node_boot_time_seconds,Name)",
            "hide": 0,
            "includeAll": false,
            "multi": false,
            "name": "vm",
            "options": [],
            "query": {
              "query": "label_values(node_boot_time_seconds,Name)",
              "refId": "StandardVariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          }
        ]
      },
      "time": {
        "from": "now-1h",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "5s",
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ],
        "time_options": [
          "5m",
          "15m",
          "1h",
          "6h",
          "12h",
          "24h",
          "2d",
          "7d",
          "30d"
        ]
      },
      "timezone": "",
      "title": "VM metrics",
      "uid": "11442VErX96k2aJw",
      "version": 1,
      "weekStart": ""
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "latest"
}
```

---

# helm

## helm/dagster-daemon

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "helm",
  "metadata": {
    "name": "dagster-daemon"
  },
  "spec": {
    "helm": {
      "chart": "dagster-helm",
      "namespace": "dagster",
      "repository": "../stacks/onelens-4786099461/helm_charts",
      "version": "1.9.11",
      "wait": false
    },
    "values": {
      "PersistentVolume": {
        "enabled": true,
        "name": "efs-persistent-volume-${blueprint.self.variables.ENV}",
        "volumeHandle": "${aws_efs.dagster-efs.out.attributes.file_system_id}"
      },
      "PersistentVolume2": {
        "enabled": false
      },
      "PersistentVolumeClaim": {
        "enabled": true,
        "environment": "${blueprint.self.variables.ENV}"
      },
      "PersistentVolumeClaim2": {
        "enabled": false
      },
      "Role": {
        "enabled": true
      },
      "RoleBinding": {
        "enabled": true
      },
      "Secret": {
        "data": {
          "postgresql-password": "${postgres.dagster-db.out.interfaces.writer.password}"
        },
        "enabled": true
      },
      "ServiceAccount": {
        "enabled": false
      },
      "ServiceAccountdagster": {
        "enabled": true,
        "role_arn": "${aws_iam_role.full-services-access.out.attributes.irsa_iam_role_arn}"
      },
      "StorageClass": {
        "enabled": true,
        "fileSystemId": "${aws_efs.dagster-efs.out.attributes.file_system_id}"
      },
      "StorageClassStandard": {
        "enabled": false
      },
      "configMap": {
        "enabled": false
      },
      "dagsterjobaccess": {
        "enabled": false
      },
      "deployment": {
        "enabled": true,
        "labels": {
          "component": "dagster-daemon",
          "environment": "test",
          "module": "core-platform",
          "product": "onelens",
          "purpose": "tooling",
          "resource-type": "service",
          "shared": "true"
        }
      },
      "env": [
        {
          "name": "ANOMALY_RELEVANCY_PERIOD_DAYS",
          "value": 90
        },
        {
          "name": "OCULUS_TRANSFORMATION_CONCURRENCY_LIMIT",
          "value": 2
        },
        {
          "name": "CUR_IMPORT_PERIOD",
          "value": "${blueprint.self.variables.CUR_IMPORT_PERIOD}"
        },
        {
          "name": "KMS_KEY",
          "value": "${blueprint.self.secrets.KMS_KEY}"
        },
        {
          "name": "DATA_HARVEST_JOB_POLL_TIME_IN_SEC",
          "value": "${blueprint.self.variables.DATA_HARVEST_JOB_POLL_TIME_IN_SEC}"
        },
        {
          "name": "ENV",
          "value": "${blueprint.self.variables.ENV}"
        },
        {
          "name": "ONELENS_BACKEND_API_URL",
          "value": "https://${ingress.public-ingress.out.interfaces.onelens-backend_ingress-onelens-backend.host}"
        },
        {
          "name": "DAGSTER_POSTGRES_HOSTNAME",
          "value": "${postgres.dagster-db.out.interfaces.writer.host}"
        },
        {
          "name": "DAGSTER_WEBSERVER_HOSTNAME",
          "value": "${ingress.dagster.out.interfaces.facets_dagster-webserver.host}"
        },
        {
          "name": "DAGSTER_POSTGRES_USER",
          "value": "${postgres.dagster-db.out.interfaces.writer.username}"
        },
        {
          "name": "DATA_HARVEST_RETRY_INTERVAL_IN_SEC",
          "value": 2
        },
        {
          "name": "DATA_HARVEST_API_URL",
          "value": "https://${ingress.public-ingress.out.interfaces.onelens-backend_ingress-data-harvest.host}"
        },
        {
          "name": "CUR_BUCKET_NAME",
          "value": "${s3.onelens-tenants-cur.out.attributes.bucket_name}"
        },
        {
          "name": "MAX_CONCURRENT_JOBS_EXECUTION_COUNT",
          "value": "${blueprint.self.variables.MAX_CONCURRENT_JOBS_EXECUTION_COUNT}"
        },
        {
          "name": "DAGSTER_POSTGRES_DB",
          "value": "${blueprint.self.variables.DAGSTER_POSTGRES_DB}"
        },
        {
          "name": "DAGSTER_WEBSERVER_PORT",
          "value": 3000
        },
        {
          "name": "DATA_HARVEST_RETRY_COUNT",
          "value": 5
        },
        {
          "name": "DAGSTER_CURRENT_IMAGE",
          "value": "${blueprint.self.variables.DAGSTER_CURRENT_IMAGE}"
        },
        {
          "name": "TENANT_PIPEPINE_DIR",
          "value": "/dagster-efs"
        },
        {
          "name": "HARVESTING_CRON_SCHEDULE",
          "value": "${blueprint.self.variables.HARVESTING_CRON_SCHEDULE}"
        },
        {
          "name": "DAGSTER_S3_GLOBAL",
          "value": "${s3.onelens-data.out.attributes.bucket_name}"
        },
        {
          "name": "GOOGLE_GEMINI_API_KEY",
          "value": "${blueprint.self.secrets.GOOGLE_GEMINI_API_KEY}"
        },
        {
          "name": "DAGSTER_POSTGRES_PASSWORD",
          "value": "${postgres.dagster-db.out.interfaces.writer.password}"
        },
        {
          "name": "ONELENS_BACKEND_API_SECRET_TOKEN",
          "value": "${blueprint.self.secrets.ONELENS_BACKEND_API_SECRET_TOKEN}"
        },
        {
          "name": "TEAMS_WEBHOOK_URL",
          "value": "${blueprint.self.secrets.TEAMS_WEBHOOK_URL}"
        },
        {
          "name": "AZURE_API_VERSION",
          "value": "${blueprint.self.variables.AZURE_API_VERSION}"
        },
        {
          "name": "AZURE_OPENAI_ENDPOINT",
          "value": "${blueprint.self.variables.AZURE_OPENAI_ENDPOINT}"
        },
        {
          "name": "DAGSTER_DBT_PARSE_PROJECT_ON_LOAD",
          "value": "1"
        },
        {
          "name": "POSTGRES_CONCURRENCY_LIMIT",
          "value": "1"
        },
        {
          "name": "DAGSTER_WEBSERVER_USE_HTTPS",
          "value": "${blueprint.self.variables.DAGSTER_WEBSERVER_USE_HTTPS}"
        },
        {
          "name": "REASONING_AZURE_OPENAI_API_KEY",
          "value": "${blueprint.self.secrets.REASONING_AZURE_OPENAI_API_KEY}"
        },
        {
          "name": "AZURE_OPENAI_API_KEY",
          "value": "${blueprint.self.secrets.AZURE_OPENAI_API_KEY}"
        },
        {
          "name": "DAGSTER_MAX_RUNTIME_SECONDS",
          "value": "${blueprint.self.variables.DAGSTER_MAX_RUNTIME_SECONDS}"
        },
        {
          "name": "REASONING_AZURE_API_VERSION",
          "value": "${blueprint.self.variables.REASONING_AZURE_API_VERSION}"
        },
        {
          "name": "REASONING_AZURE_OPENAI_ENDPOINT",
          "value": "${blueprint.self.variables.REASONING_AZURE_OPENAI_ENDPOINT}"
        },
        {
          "name": "ONYX_SECRET_TOKEN",
          "value": "${blueprint.self.secrets.ONYX_SECRET_TOKEN}"
        },
        {
          "name": "ONYX_API_URL",
          "value": "${blueprint.self.variables.ONYX_API_URL}"
        },
        {
          "name": "CUR_CLOUD_PROVIDER",
          "value": "${blueprint.self.variables.CUR_CLOUD_PROVIDER}"
        },
        {
          "name": "GCP_CUR_BUCKET_NAME",
          "value": "${google_cloud_storage.tenant-cur.out.attributes.name}"
        },
        {
          "name": "GCP_CREDENTIALS",
          "value": "${blueprint.self.secrets.GCP_CREDENTIALS}"
        },
        {
          "name": "GCP_STORAGE_ACCESS_KEY",
          "value": "${blueprint.self.secrets.GCP_STORAGE_ACCESS_KEY}"
        },
        {
          "name": "GCP_STORAGE_SECRET_KEY",
          "value": "${blueprint.self.secrets.GCP_STORAGE_SECRET_KEY}"
        },
        {
          "name": "CUR_DELTA_QUEUE",
          "value": "${sqs.onyx-cur-delta.out.attributes.sqs_queue_name}"
        },
        {
          "name": "GLOBAL_MULTI_TENANT_FAILURE_SENSOR_TEAMS_WEBHOOK_URL",
          "value": "${blueprint.self.secrets.GLOBAL_MULTI_TENANT_FAILURE_SENSOR_TEAMS_WEBHOOK_URL}"
        },
        {
          "name": "DAGSTER_RUN_DATA_CLEANUP_CONCURRENCY_LIMIT",
          "value": "${blueprint.self.variables.DAGSTER_RUN_DATA_CLEANUP_CONCURRENCY_LIMIT}"
        },
        {
          "name": "DAGSTER_MAX_RUNTIME_SECONDS_FOR_DAGSTER_RUN_DATA_CLEANUP_JOB",
          "value": "${blueprint.self.variables.DAGSTER_MAX_RUNTIME_SECONDS_FOR_DAGSTER_RUN_DATA_CLEANUP_JOB}"
        }
      ],
      "environment": "${blueprint.self.variables.ENV}",
      "image": {
        "pullPolicy": "Always",
        "repository": "${split(\":\", \"${blueprint.self.artifacts.onelens-4786099461-dagster-daemon}\")[0]}",
        "tags": "${split(\":\", \"${blueprint.self.artifacts.onelens-4786099461-dagster-daemon}\")[1]}"
      },
      "ingress": {
        "enabled": false
      },
      "resources": {
        "limits": {
          "cpu": "1500m",
          "memory": "4000Mi"
        },
        "requests": {
          "cpu": "1500m",
          "memory": "3000Mi"
        }
      },
      "service": {
        "enabled": false
      }
    }
  },
  "version": "0.1"
}
```

---

## helm/dagster-webserver

```json
{
  "disabled": false,
  "flavor": "k8s",
  "kind": "helm",
  "metadata": {
    "name": "dagster-webserver"
  },
  "spec": {
    "helm": {
      "chart": "dagster-helm",
      "namespace": "dagster",
      "repository": "../stacks/onelens-4786099461/helm_charts",
      "version": "1.9.11",
      "wait": false
    },
    "values": {
      "PersistentVolume": {
        "enabled": false,
        "name": "efs-persistent-volume-${blueprint.self.variables.ENV}",
        "volumeHandle": "${aws_efs.dagster-efs.out.attributes.file_system_id}"
      },
      "PersistentVolume2": {
        "enabled": false
      },
      "PersistentVolumeClaim": {
        "enabled": false,
        "environment": "${blueprint.self.variables.ENV}"
      },
      "PersistentVolumeClaim2": {
        "enabled": false
      },
      "Role": {
        "enabled": false
      },
      "RoleBinding": {
        "enabled": false
      },
      "Secret": {
        "enabled": false
      },
      "ServiceAccount": {
        "enabled": false
      },
      "ServiceAccountdagster": {
        "enabled": false
      },
      "StorageClass": {
        "enabled": false,
        "fileSystemId": "${aws_efs.dagster-efs.out.attributes.file_system_id}"
      },
      "StorageClassStandard": {
        "enabled": false
      },
      "configMap": {
        "enabled": false
      },
      "dagsterjobaccess": {
        "enabled": false
      },
      "deployment": {
        "enabled": true,
        "labels": {
          "component": "dagster-webserver",
          "environment": "test",
          "module": "core-platform",
          "product": "onelens",
          "purpose": "tooling",
          "resource-type": "service",
          "shared": "true"
        }
      },
      "env": [
        {
          "name": "ANOMALY_RELEVANCY_PERIOD_DAYS",
          "value": 90
        },
        {
          "name": "OCULUS_TRANSFORMATION_CONCURRENCY_LIMIT",
          "value": 2
        },
        {
          "name": "CUR_IMPORT_PERIOD",
          "value": "${blueprint.self.variables.CUR_IMPORT_PERIOD}"
        },
        {
          "name": "KMS_KEY",
          "value": "${blueprint.self.secrets.KMS_KEY}"
        },
        {
          "name": "DATA_HARVEST_JOB_POLL_TIME_IN_SEC",
          "value": "${blueprint.self.variables.DATA_HARVEST_JOB_POLL_TIME_IN_SEC}"
        },
        {
          "name": "ENV",
          "value": "${blueprint.self.variables.ENV}"
        },
        {
          "name": "ONELENS_BACKEND_API_URL",
          "value": "https://${ingress.public-ingress.out.interfaces.onelens-backend_ingress-onelens-backend.host}"
        },
        {
          "name": "DAGSTER_POSTGRES_HOSTNAME",
          "value": "${postgres.dagster-db.out.interfaces.writer.host}"
        },
        {
          "name": "DAGSTER_POSTGRES_USER",
          "value": "${postgres.dagster-db.out.interfaces.writer.username}"
        },
        {
          "name": "DATA_HARVEST_RETRY_INTERVAL_IN_SEC",
          "value": 2
        },
        {
          "name": "DATA_HARVEST_API_URL",
          "value": "https://${ingress.public-ingress.out.interfaces.onelens-backend_ingress-data-harvest.host}"
        },
        {
          "name": "CUR_BUCKET_NAME",
          "value": "${s3.onelens-tenants-cur.out.attributes.bucket_name}"
        },
        {
          "name": "MAX_CONCURRENT_JOBS_EXECUTION_COUNT",
          "value": "${blueprint.self.variables.MAX_CONCURRENT_JOBS_EXECUTION_COUNT}"
        },
        {
          "name": "DAGSTER_POSTGRES_DB",
          "value": "${blueprint.self.variables.DAGSTER_POSTGRES_DB}"
        },
        {
          "name": "DAGSTER_WEBSERVER_PORT",
          "value": 3000
        },
        {
          "name": "DATA_HARVEST_RETRY_COUNT",
          "value": 5
        },
        {
          "name": "DAGSTER_CURRENT_IMAGE",
          "value": "${blueprint.self.variables.DAGSTER_CURRENT_IMAGE}"
        },
        {
          "name": "TENANT_PIPEPINE_DIR",
          "value": "/dagster-efs"
        },
        {
          "name": "HARVESTING_CRON_SCHEDULE",
          "value": "${blueprint.self.variables.HARVESTING_CRON_SCHEDULE}"
        },
        {
          "name": "DAGSTER_S3_GLOBAL",
          "value": "${s3.onelens-data.out.attributes.bucket_name}"
        },
        {
          "name": "GOOGLE_GEMINI_API_KEY",
          "value": "${blueprint.self.secrets.GOOGLE_GEMINI_API_KEY}"
        },
        {
          "name": "DAGSTER_POSTGRES_PASSWORD",
          "value": "${postgres.dagster-db.out.interfaces.writer.password}"
        },
        {
          "name": "ONELENS_BACKEND_API_SECRET_TOKEN",
          "value": "${blueprint.self.secrets.ONELENS_BACKEND_API_SECRET_TOKEN}"
        },
        {
          "name": "TEAMS_WEBHOOK_URL",
          "value": "${blueprint.self.secrets.TEAMS_WEBHOOK_URL}"
        },
        {
          "name": "AZURE_API_VERSION",
          "value": "${blueprint.self.variables.AZURE_API_VERSION}"
        },
        {
          "name": "AZURE_OPENAI_ENDPOINT",
          "value": "${blueprint.self.variables.AZURE_OPENAI_ENDPOINT}"
        },
        {
          "name": "DAGSTER_DBT_PARSE_PROJECT_ON_LOAD",
          "value": "1"
        },
        {
          "name": "POSTGRES_CONCURRENCY_LIMIT",
          "value": "1"
        },
        {
          "name": "DAGSTER_WEBSERVER_USE_HTTPS",
          "value": "${blueprint.self.variables.DAGSTER_WEBSERVER_USE_HTTPS}"
        },
        {
          "name": "REASONING_AZURE_OPENAI_API_KEY",
          "value": "${blueprint.self.secrets.REASONING_AZURE_OPENAI_API_KEY}"
        },
        {
          "name": "AZURE_OPENAI_API_KEY",
          "value": "${blueprint.self.secrets.AZURE_OPENAI_API_KEY}"
        },
        {
          "name": "DAGSTER_MAX_RUNTIME_SECONDS",
          "value": "${blueprint.self.variables.DAGSTER_MAX_RUNTIME_SECONDS}"
        },
        {
          "name": "DAGSTER_WEBSERVER_HOSTNAME",
          "value": "${ingress.dagster.out.interfaces.facets_dagster-webserver.host}"
        },
        {
          "name": "REASONING_AZURE_API_VERSION",
          "value": "${blueprint.self.variables.REASONING_AZURE_API_VERSION}"
        },
        {
          "name": "REASONING_AZURE_OPENAI_ENDPOINT",
          "value": "${blueprint.self.variables.REASONING_AZURE_OPENAI_ENDPOINT}"
        },
        {
          "name": "ONYX_SECRET_TOKEN",
          "value": "${blueprint.self.secrets.ONYX_SECRET_TOKEN}"
        },
        {
          "name": "ONYX_API_URL",
          "value": "${blueprint.self.variables.ONYX_API_URL}"
        },
        {
          "name": "CUR_CLOUD_PROVIDER",
          "value": "${blueprint.self.variables.CUR_CLOUD_PROVIDER}"
        },
        {
          "name": "GCP_CUR_BUCKET_NAME",
          "value": "${google_cloud_storage.tenant-cur.out.attributes.name}"
        },
        {
          "name": "GCP_CREDENTIALS",
          "value": "${blueprint.self.secrets.GCP_CREDENTIALS}"
        },
        {
          "name": "GCP_STORAGE_ACCESS_KEY",
          "value": "${blueprint.self.secrets.GCP_STORAGE_ACCESS_KEY}"
        },
        {
          "name": "GCP_STORAGE_SECRET_KEY",
          "value": "${blueprint.self.secrets.GCP_STORAGE_SECRET_KEY}"
        },
        {
          "name": "CUR_DELTA_QUEUE",
          "value": "${sqs.onyx-cur-delta.out.attributes.sqs_queue_name}"
        },
        {
          "name": "GLOBAL_MULTI_TENANT_FAILURE_SENSOR_TEAMS_WEBHOOK_URL",
          "value": "${blueprint.self.secrets.GLOBAL_MULTI_TENANT_FAILURE_SENSOR_TEAMS_WEBHOOK_URL}"
        },
        {
          "name": "DAGSTER_RUN_DATA_CLEANUP_CONCURRENCY_LIMIT",
          "value": "${blueprint.self.variables.DAGSTER_RUN_DATA_CLEANUP_CONCURRENCY_LIMIT}"
        },
        {
          "name": "DAGSTER_MAX_RUNTIME_SECONDS_FOR_DAGSTER_RUN_DATA_CLEANUP_JOB",
          "value": "${blueprint.self.variables.DAGSTER_MAX_RUNTIME_SECONDS_FOR_DAGSTER_RUN_DATA_CLEANUP_JOB}"
        }
      ],
      "environment": "${blueprint.self.variables.ENV}",
      "image": {
        "pullPolicy": "Always",
        "repository": "${split(\":\", \"${blueprint.self.artifacts.onelens-4786099461-dagster-webserver}\")[0]}",
        "tags": "${split(\":\", \"${blueprint.self.artifacts.onelens-4786099461-dagster-webserver}\")[1]}"
      },
      "ingress": {
        "enabled": false
      },
      "resources": {
        "limits": {
          "cpu": "2000m",
          "memory": "6000Mi"
        },
        "requests": {
          "cpu": "1500m",
          "memory": "3000Mi"
        }
      },
      "service": {
        "enabled": true
      }
    }
  },
  "version": "0.1"
}
```

---

## helm/k8s-dashboard-new

```json
{
  "$schema": "https://docs.facets.cloud/schemas/helm/instances/helm.schema",
  "advanced": {
    "inherit_from_base": true
  },
  "disabled": false,
  "flavor": "helm_simple",
  "metadata": {
    "name": "k8s-dashboard-new"
  },
  "spec": {
    "env": [],
    "helm": {
      "chart": "https://kubernetes.github.io/dashboard/kubernetes-dashboard-5.1.1.tgz",
      "namespace": "default",
      "recreate_pods": false,
      "version": "5.1.1",
      "wait": true
    },
    "values": {
      "resources": {
        "limits": {
          "memory": "512Mi"
        },
        "requests": {
          "memory": "512Mi"
        }
      },
      "tolerations": [
        {
          "effect": "NoSchedule",
          "key": "kubernetes.azure.com/scalesetpriority",
          "operator": "Equal",
          "value": "spot"
        }
      ]
    }
  },
  "ui": {
    "base_resource": true
  }
}
```

---

# iam_policy

## iam_policy/full-services-access

```json
{
  "disabled": false,
  "flavor": "aws_iam_policy",
  "kind": "iam_policy",
  "metadata": {
    "annotations": {},
    "name": "full-services-access"
  },
  "spec": {
    "name": "full-service-access-${blueprint.self.variables.ENV}",
    "policy": {
      "Statement": [
        {
          "Action": [
            "dynamodb:*"
          ],
          "Effect": "Allow",
          "Resource": "*"
        },
        {
          "Action": [
            "es:*"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:es:ap-south-1:609916866699:domain/*"
        },
        {
          "Action": [
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:DescribeLogStreams",
            "logs:DescribeLogGroups",
            "logs:PutRetentionPolicy",
            "xray:PutTraceSegments",
            "xray:PutTelemetryRecords",
            "xray:GetSamplingRules",
            "xray:GetSamplingTargets",
            "xray:GetSamplingStatisticSummaries",
            "ssm:GetParameters"
          ],
          "Effect": "Allow",
          "Resource": "*"
        },
        {
          "Action": [
            "ssm:GetParameter",
            "ssm:GetParameters"
          ],
          "Effect": "Allow",
          "Resource": [
            "arn:aws:ssm:ap-south-1:609916866699:parameter/*"
          ]
        },
        {
          "Action": [
            "sts:AssumeRole"
          ],
          "Effect": "Allow",
          "Resource": [
            "arn:aws:iam::*:role/astuto-finops-integration-role",
            "arn:aws:iam::*:role/*OneLens*"
          ]
        },
        {
          "Action": [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel"
          ],
          "Effect": "Allow",
          "Resource": "*"
        },
        {
          "Action": [
            "sqs:*"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
      ],
      "Version": "2012-10-17"
    }
  },
  "version": "0.2"
}
```

---

## iam_policy/ol-sch-handler

```json
{
  "disabled": false,
  "flavor": "aws_iam_policy",
  "kind": "iam_policy",
  "metadata": {
    "annotations": {},
    "name": "ol-sch-handler"
  },
  "spec": {
    "name": "OnelensSchedulerRequestHandler-Policy",
    "policy": {
      "Statement": [
        {
          "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:logs:*:*:log-group:/aws/lambda/OnelensSchedulerRequestHandler:*"
        },
        {
          "Action": [
            "sqs:ReceiveMessage",
            "sqs:DeleteMessage",
            "sqs:GetQueueAttributes",
            "sqs:ChangeMessageVisibility"
          ],
          "Effect": "Allow",
          "Resource": [
            "arn:aws:sqs:ap-southeast-1:471112792234:onelens-scheduler-requests-queue.fifo"
          ]
        },
        {
          "Action": [
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:UpdateItem",
            "dynamodb:DeleteItem",
            "dynamodb:Query",
            "dynamodb:Scan",
            "dynamodb:DescribeTable"
          ],
          "Effect": "Allow",
          "Resource": [
            "${dynamodb.ol-scheduler-configs.out.attributes.table_arn}",
            "${dynamodb.ol-scheduler-exec.out.attributes.table_arn}",
            "${dynamodb.ol-schedulers.out.attributes.table_arn}",
            "${dynamodb.ol-scheduler-tnt-cfg.out.attributes.table_arn}",
            "${dynamodb.ol-scheduler-audit.out.attributes.table_arn}"
          ]
        },
        {
          "Action": [
            "sts:AssumeRole"
          ],
          "Condition": {
            "StringLike": {
              "aws:ResourceArn": "arn:aws:iam::*:role/OnelensSQSMessageSenderRole*"
            }
          },
          "Effect": "Allow",
          "Resource": "*"
        }
      ],
      "Version": "2012-10-17"
    }
  },
  "version": "0.2"
}
```

---

## iam_policy/onyx-permissions

```json
{
  "disabled": false,
  "flavor": "aws_iam_policy",
  "kind": "iam_policy",
  "metadata": {
    "name": "onyx-permissions"
  },
  "spec": {
    "name": "onyx_permissions",
    "policy": {
      "Statement": [
        {
          "Action": [
            "iam:PassRole",
            "iam:GetRole"
          ],
          "Effect": "Allow",
          "Resource": [
            "${aws_iam_role.onyx-workflow-step-function-role.out.attributes.irsa_iam_role_arn}",
            "arn:aws:iam::${element(split(\":\", var.cluster.roleARN), 4)}:role/onyx-*"
          ]
        },
        {
          "Action": [
            "sqs:*",
            "sqs:sendmessage"
          ],
          "Effect": "Allow",
          "Resource": [
            "arn:aws:sqs:${var.cluster.awsRegion}:${element(split(\":\", var.cluster.roleARN), 4)}:onyx-*",
            "arn:aws:sqs:*:*:Onyx-*"
          ]
        },
        {
          "Action": [
            "s3:*"
          ],
          "Effect": "Allow",
          "Resource": [
            "arn:aws:s3:::*-onyx-*",
            "arn:aws:s3:::*-onyx-*/*",
            "arn:aws:s3:::*-onelens-*",
            "arn:aws:s3:::*-onelens-*/*",
            "arn:aws:s3:::onelens-*",
            "arn:aws:s3:::onelens-*/*"
          ]
        },
        {
          "Action": [
            "dynamodb:*"
          ],
          "Effect": "Allow",
          "Resource": [
            "arn:aws:dynamodb:${var.cluster.awsRegion}:${element(split(\":\", var.cluster.roleARN), 4)}:table/onyx-*",
            "arn:aws:dynamodb:${var.cluster.awsRegion}:${element(split(\":\", var.cluster.roleARN), 4)}:table/onelens-*"
          ]
        },
        {
          "Action": [
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath"
          ],
          "Effect": "Allow",
          "Resource": [
            "arn:aws:ssm:${var.cluster.awsRegion}:${element(split(\":\", var.cluster.roleARN), 4)}:parameter/onyx/*",
            "arn:aws:ssm:${var.cluster.awsRegion}:${element(split(\":\", var.cluster.roleARN), 4)}:parameter/test/onelensbackend/*"
          ]
        },
        {
          "Action": [
            "es:*"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:es:${var.cluster.awsRegion}:${element(split(\":\", var.cluster.roleARN), 4)}:domain/*"
        },
        {
          "Action": [
            "elasticfilesystem:*"
          ],
          "Effect": "Allow",
          "Resource": "*"
        },
        {
          "Action": [
            "sns:*"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:sns:${var.cluster.awsRegion}:${element(split(\":\", var.cluster.roleARN), 4)}:onyx-*"
        },
        {
          "Action": [
            "events:*"
          ],
          "Effect": "Allow",
          "Resource": "*"
        },
        {
          "Action": [
            "states:*"
          ],
          "Effect": "Allow",
          "Resource": "*"
        },
        {
          "Action": [
            "ec2:DeleteSnapshot",
            "ec2:DescribeSnapshots"
          ],
          "Effect": "Allow",
          "Resource": "*"
        },
        {
          "Action": [
            "scheduler:CreateSchedule",
            "scheduler:DeleteSchedule"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:scheduler:${var.cluster.awsRegion}:${element(split(\":\", var.cluster.roleARN), 4)}:schedule/onyx-*/*"
        },
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Resource": "arn:aws:iam::*:role/Onyx-Orchestrator-Readonly-Role"
        }
      ],
      "Version": "2012-10-17"
    }
  },
  "version": "0.2"
}
```

---

# ingress

## ingress/dagster

```json
{
  "disabled": false,
  "flavor": "aws_alb",
  "kind": "ingress",
  "metadata": {
    "annotations": {
      "alb.ingress.kubernetes.io/auth-idp-cognito": "{\"UserPoolArn\": \"${aws_cognito.dagster-access.out.attributes.arn}\",\"UserPoolClientId\":\"${aws_cognito.dagster-access.out.attributes.client_ids_map.dagster-access}\",\"UserPoolDomain\":\"${aws_cognito.dagster-access.out.attributes.cognito_prefix_domain}\"}",
      "alb.ingress.kubernetes.io/auth-on-unauthenticated-request": "authenticate",
      "alb.ingress.kubernetes.io/auth-scope": "openid",
      "alb.ingress.kubernetes.io/auth-session-cookie": "AWSELBAuthSessionCookie",
      "alb.ingress.kubernetes.io/auth-session-timeout": "3600",
      "alb.ingress.kubernetes.io/auth-type": "cognito",
      "alb.ingress.kubernetes.io/conditions.dagster-webserver-service": "[{\"type\":\"Header\",\"headerConfig\":{\"key\":\"x-ol-secret-token\",\"values\":[\"${blueprint.self.secrets.OL_TOKEN}\"]}}]",
      "alb.ingress.kubernetes.io/listen-ports": "[{\"HTTPS\": 443},{\"HTTP\": 80},{\"HTTP\": 3000}]"
    },
    "name": "dagster",
    "namespace": "dagster"
  },
  "spec": {
    "basic_auth": false,
    "domains": {
      "dagster-in": {
        "alias": "dagster-in",
        "certificate_reference": "${blueprint.self.variables.ONELENS_CERT_ARN}",
        "domain": "onelens.cloud"
      }
    },
    "force_ssl_redirection": false,
    "grpc": false,
    "private": false,
    "rules": {
      "dagster-in": {
        "domain_prefix": "dagster-${blueprint.self.variables.ENV}",
        "path": "/",
        "port": "80",
        "service_name": "dagster-webserver-service"
      },
      "dagster-webserver": {
        "domain_prefix": "dagster-webserver",
        "path": "/",
        "port": "80",
        "service_name": "dagster-webserver-service"
      }
    }
  },
  "version": "0.2"
}
```

---

## ingress/public-ingress

```json
{
  "disabled": false,
  "flavor": "aws_alb",
  "kind": "ingress",
  "metadata": {
    "annotations": {
      "alb.ingress.kubernetes.io/listen-ports": "[{\"HTTPS\": 443},{\"HTTP\": 80},{\"HTTP\": 3000}]",
      "alb.ingress.kubernetes.io/ssl-policy": "ELBSecurityPolicy-TLS13-1-3-2021-06"
    },
    "name": "public-ingress",
    "namespace": "dagster"
  },
  "spec": {
    "basic_auth": false,
    "domains": {
      "onelens-backend": {
        "alias": "onelens-backend",
        "certificate_reference": "${blueprint.self.variables.ONELENS_CERT_ARN}",
        "domain": "onelens.cloud"
      }
    },
    "force_ssl_redirection": false,
    "grpc": false,
    "private": false,
    "rules": {
      "ingress-data-harvest": {
        "domain_prefix": "dh-${blueprint.self.variables.ENV}",
        "path": "/",
        "port": "8000",
        "service_name": "${service.data-harvest.out.attributes.service_name}"
      },
      "ingress-onelens-backend": {
        "domain_prefix": "api-${blueprint.self.variables.ENV}",
        "path": "/",
        "port": "8000",
        "service_name": "${service.onelens-backend.out.attributes.service_name}"
      },
      "ingress-pmt": {
        "domain_prefix": "pmt-${blueprint.self.variables.ENV}",
        "path": "/",
        "port": "8502",
        "service_name": "${service.policy-master-tool.out.attributes.service_name}"
      }
    }
  },
  "version": "0.2"
}
```

---

## ingress/public-nlb-ingress

```json
{
  "disabled": false,
  "flavor": "gcp_alb",
  "kind": "ingress",
  "metadata": {
    "annotations": {
      "alb.ingress.kubernetes.io/listen-ports": "[{\"HTTPS\": 443},{\"HTTP\": 80}]",
      "alb.ingress.kubernetes.io/load-balancer-attributes": "idle_timeout.timeout_seconds=600",
      "cloud.google.com/backend-config": "{\"default\": \"public-nlb-backend-config\"}"
    },
    "name": "public-nlb-ingress",
    "namespace": "onyx"
  },
  "spec": {
    "basic_auth": false,
    "domains": {
      "onyx-app": {
        "alias": "onyx-app",
        "certificate_reference": "onyx",
        "domain": "api.onyx-${blueprint.self.variables.ENV}.onelens.cloud"
      }
    },
    "force_ssl_redirection": true,
    "grpc": false,
    "private": false,
    "rules": {
      "onyx-ai-insights-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/ai",
        "port": "80",
        "service_name": "${service.onyx-ai-insights-api.out.interfaces.http.name}"
      },
      "onyx-authentication-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/auth",
        "port": "80",
        "service_name": "${service.onyx-authentication-api.out.attributes.service_name}"
      },
      "onyx-cost-center-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/cost-center",
        "port": "80",
        "service_name": "${service.onyx-cost-center-api.out.attributes.service_name}"
      },
      "onyx-dashboard-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/dashboard",
        "port": "80",
        "service_name": "${service.onyx-dashboard-api.out.interfaces.http.name}"
      },
      "onyx-dataware-house-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/dataware-house",
        "port": "80",
        "service_name": "${service.onyx-dataware-house-api.out.attributes.service_name}"
      },
      "onyx-dataware-house-api-temp": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/dataware-house-v2",
        "port": "80",
        "service_name": "${service.onyx-dataware-house-api-temp.out.interfaces.http.name}"
      },
      "onyx-integrations-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/integrations",
        "port": "80",
        "service_name": "${service.onyx-integrations-api.out.attributes.service_name}"
      },
      "onyx-request-processor-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/rp",
        "port": "80",
        "service_name": "${service.onyx-request-processor-api.out.attributes.service_name}"
      },
      "onyx-runbook-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/runbooks",
        "port": "80",
        "service_name": "${service.onyx-runbooks-api.out.attributes.service_name}"
      },
      "onyx-scheduler-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/scheduler",
        "port": "80",
        "service_name": "${service.onyx-scheduler-api.out.interfaces.http.name}"
      },
      "onyx-workflow-actions-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/workflow/actions",
        "port": "80",
        "service_name": "${service.onyx-workflow-actions-api.out.attributes.service_name}"
      },
      "onyx-workflow-mgmt-api": {
        "grpc": false,
        "namespace": "onyx",
        "path": "/api/workflow/management",
        "port": "80",
        "service_name": "${service.onyx-workflow-mgmt-api.out.attributes.service_name}"
      }
    }
  },
  "version": "0.2"
}
```

---

## ingress/tools

```json
{
  "advanced": {
    "inherit_from_base": true,
    "nginx_ingress_controller": {
      "values": {
        "controller": {
          "autoscaling": {
            "minReplicas": 1
          },
          "config": {
            "use-forwarded-headers": true
          }
        }
      }
    }
  },
  "flavor": "nginx_k8s_native",
  "kind": "ingress",
  "metadata": {
    "annotations": {},
    "name": "tools"
  },
  "spec": {
    "basicAuth": true,
    "domains": {},
    "force_ssl_redirection": true,
    "grpc": false,
    "private": false,
    "rules": {
      "alertmanager": {
        "domain_prefix": "alertmanager",
        "path": "/",
        "port": 9093,
        "service_name": "prometheus-operator-alertmanager"
      },
      "argo": {
        "domain_prefix": "argo-rollouts",
        "path": "/",
        "port": "3100",
        "service_name": "argo-facets-argo-rollouts-dashboard"
      },
      "grafana": {
        "domain_prefix": "grafana",
        "path": "/",
        "port": 80,
        "service_name": "prometheus-operator-grafana"
      },
      "k8s": {
        "annotations": {
          "nginx.ingress.kubernetes.io/backend-protocol": "HTTPS"
        },
        "disable_auth": true,
        "domain_prefix": "k8s",
        "path": "/",
        "port": 443,
        "service_name": "k8s-dashboard-new-kubernetes-dashboard"
      },
      "prometheus": {
        "domain_prefix": "prometheus",
        "path": "/",
        "port": 9090,
        "service_name": "prometheus-operator-prometheus"
      },
      "wetty": {
        "domain_prefix": "wetty",
        "path": "/",
        "port": 3000,
        "service_name": "wetty"
      }
    }
  },
  "ui": {
    "base_resource": true
  },
  "version": "0.1"
}
```

---

# kms

## kms/onelens-key

```json
{
  "disabled": false,
  "flavor": "default",
  "kind": "kms",
  "metadata": {
    "name": "onelens-key"
  },
  "spec": {},
  "version": "0.1"
}
```

---

# kubernetes_cluster

## kubernetes_cluster/default

```json
{
  "advanced": {
    "default": {
      "include_cluster_code_in_name": true
    },
    "inherit_from_base": true
  },
  "disabled": false,
  "flavor": "default",
  "inputs": {},
  "kind": "kubernetes_cluster",
  "metadata": {
    "name": "default"
  },
  "provided": false,
  "spec": {},
  "ui": {
    "base_resource": true
  },
  "version": "0.1"
}
```

---

# kubernetes_monitoring

## kubernetes_monitoring/default

```json
{
  "advanced": {
    "inherit_from_base": true,
    "k8s": {
      "event_exporter": {
        "env": [],
        "helm": {
          "chart": "event-exporter",
          "namespace": "default",
          "recreate_pods": false,
          "repository": "https://facets-cloud.github.io/event_exporter/helm/charts/",
          "version": "0.1.1",
          "wait": true
        },
        "values": {
          "extraArgs": [
            "--customFilter={\"InvolvedObjectName\": \"cluster-autoscaler-status\", \"EventTypes\": [\"Warning\", \"Normal\"]}"
          ],
          "image": {
            "pullPolicy": "IfNotPresent",
            "tag": "latest"
          },
          "serviceAccount": {
            "create": true,
            "name": "event-exporter"
          },
          "tolerations": [
            {
              "effect": "NoSchedule",
              "key": "kubernetes.azure.com/scalesetpriority",
              "operator": "Equal",
              "value": "spot"
            },
            {
              "effect": "NoSchedule",
              "key": "facets.cloud/dedicated",
              "operator": "Equal",
              "value": "true"
            }
          ]
        }
      },
      "k8s_ssl_validity_exporter": {
        "env": [],
        "helm": {
          "chart": "k8s-ssl-validity-exporter",
          "namespace": "default",
          "recreate_pods": false,
          "repository": "https://facets-cloud.github.io/k8s-ssl-validity-exporter/charts",
          "version": "1.0.0",
          "wait": true
        },
        "values": {
          "image": {
            "repository": "facetscloud/k8s-ingress-ssl-metrics-exporter-multi-arch",
            "tag": "latest"
          },
          "nodeSelector": {
            "kubernetes.io/os": "linux"
          },
          "tolerations": [
            {
              "effect": "NoSchedule",
              "key": "kubernetes.azure.com/scalesetpriority",
              "operator": "Equal",
              "value": "spot"
            },
            {
              "effect": "NoSchedule",
              "key": "components.gke.io/gke-managed-components",
              "operator": "Equal",
              "value": "true"
            },
            {
              "effect": "NoSchedule",
              "key": "facets.cloud/dedicated",
              "operator": "Equal",
              "value": "true"
            }
          ]
        }
      }
    }
  },
  "depends_on": [],
  "disabled": false,
  "flavor": "k8s",
  "kind": "kubernetes_monitoring",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "kubernetes_monitoring"
  },
  "out": {},
  "provided": false,
  "spec": {},
  "ui": {
    "base_resource": true
  },
  "version": "0.1"
}
```

---

# kubernetes_node_pool

## kubernetes_node_pool/jobs-node

```json
{
  "disabled": false,
  "flavor": "eks_self_managed",
  "kind": "kubernetes_node_pool",
  "metadata": {
    "name": "jobs-node"
  },
  "spec": {
    "ami_name_filter": "amazon-eks-arm64-node-1.31-v*",
    "ami_owner_id": "amazon",
    "azs": "ap-south-1a",
    "disk_size": 50,
    "instance_type": "c6g.xlarge",
    "is_public": false,
    "labels": {
      "compute_label": "ol_small"
    },
    "max_node_count": 5,
    "min_node_count": 0,
    "taints": {}
  },
  "version": "0.1"
}
```

---

# log_collector

## log_collector/loki-s3

```json
{
  "advanced": {
    "loki_s3": {
      "bucket_name": "${s3.loki-s3.out.attributes.bucket_name}"
    }
  },
  "depends_on": [],
  "disabled": false,
  "flavor": "loki_aws_s3",
  "kind": "log_collector",
  "lifecycle": "ENVIRONMENT",
  "metadata": {
    "name": "log-collector-s3"
  },
  "out": {},
  "provided": false,
  "spec": {},
  "version": "0.2"
}
```

---

# network

## network/default

```json
{
  "advanced": {
    "inherit_from_base": true
  },
  "disabled": false,
  "flavor": "default",
  "kind": "network",
  "metadata": {
    "name": "default"
  },
  "out": {
    "attributes": {}
  },
  "provided": false,
  "spec": {
    "include_cluster_code": true
  },
  "ui": {
    "base_resource": true
  },
  "version": "0.1"
}
```

---

# postgres

## postgres/dagster-db

```json
{
  "disabled": false,
  "flavor": "rds",
  "kind": "postgres",
  "metadata": {
    "name": "dagster-db"
  },
  "spec": {
    "postgres_version": "16",
    "size": {
      "reader": {
        "instance": "db.t4g.medium",
        "instance_count": 1
      },
      "writer": {
        "instance": "db.t4g.medium"
      }
    }
  },
  "version": "0.1"
}
```

---

# s3

## s3/kubernetes-s3-bucket

```json
{
  "advanced": {},
  "disabled": false,
  "flavor": "default",
  "kind": "s3",
  "metadata": {
    "name": "kubernetes-s3-bucket"
  },
  "spec": {
    "enable_import": false
  },
  "version": "0.2"
}
```

---

## s3/loki-s3

```json
{
  "advanced": {},
  "disabled": false,
  "flavor": "default",
  "kind": "s3",
  "metadata": {
    "name": "loki-s3"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## s3/onelens-data

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/s3/s3.schema.json",
  "advanced": {},
  "disabled": false,
  "flavor": "default",
  "kind": "s3",
  "metadata": {
    "name": "onelens-data"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## s3/onelens-downloads

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/s3/s3.schema.json",
  "advanced": {},
  "disabled": false,
  "flavor": "default",
  "kind": "s3",
  "metadata": {
    "name": "onelens-downloads"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## s3/onelens-tenants-cur

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/s3/s3.schema.json",
  "advanced": {},
  "disabled": false,
  "flavor": "default",
  "kind": "s3",
  "metadata": {
    "name": "onelens-tenants-cur"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## s3/onyx-backend

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/s3/s3.schema.json",
  "advanced": {},
  "disabled": false,
  "flavor": "default",
  "kind": "s3",
  "metadata": {
    "name": "onyx-backend"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## s3/onyx-workflow

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/s3/s3.schema.json",
  "advanced": {},
  "disabled": false,
  "flavor": "default",
  "kind": "s3",
  "metadata": {
    "name": "onyx-workflow"
  },
  "spec": {},
  "version": "0.2"
}
```

---

# service

## service/data-harvest

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "service_account_name": "dagster"
        }
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {},
    "labels": {
      "app": "data-harvest",
      "component": "data-harvest",
      "environment": "test",
      "module": "core-platform",
      "product": "onelens",
      "purpose": "tooling",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "data-harvest",
    "namespace": "dagster"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": false
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AWS_JOB_DEFINITION": "${aws_batchjob.dh-ec2-test-sgp.out.attributes.job_definition}",
      "AWS_JOB_NAME": "${blueprint.self.variables.AWS_JOB_NAME}",
      "AWS_JOB_QUEUE": "${aws_batchjob.dh-ec2-test-sgp.out.attributes.job_queue}",
      "AWS_KMS_KEY_ID": "${blueprint.self.secrets.KMS_KEY}",
      "AWS_REGION": "${blueprint.self.variables.AWS_REGION_DATA_HARVEST}",
      "DATA_FETCH_JOB_WORKER_COUNT": "${blueprint.self.variables.DATA_FETCH_JOB_WORKER_COUNT}",
      "DATA_HARVEST_SERVER_ENABLED": "${blueprint.self.variables.DATA_HARVEST_SERVER_ENABLED}",
      "DB_CONN_MAX_LIFE_TIME_IN_SEC": "${blueprint.self.variables.DB_CONN_MAX_LIFE_TIME_IN_SEC}",
      "DB_HOST": "${postgres.dagster-db.out.interfaces.writer.host}",
      "DB_MAX_IDLE_CONNS": "${blueprint.self.variables.DB_MAX_IDLE_CONNS}",
      "DB_MAX_OPEN_CONNS": "${blueprint.self.variables.DB_MAX_OPEN_CONNS}",
      "DB_MAX_QUERY_TIMEOUT_IN_SEC": "${blueprint.self.variables.DB_MAX_QUERY_TIMEOUT_IN_SEC}",
      "DB_NAME": "${blueprint.self.variables.DB_NAME}",
      "DB_PASSWORD": "${postgres.dagster-db.out.interfaces.writer.password}",
      "DB_PORT": "${blueprint.self.variables.DB_PORT}",
      "DB_USERNAME": "${postgres.dagster-db.out.interfaces.writer.username}",
      "DEBUG_MODE": "${blueprint.self.variables.DEBUG_MODE}",
      "DH_K8S_NODE_SELECTOR_LABEL": "${blueprint.self.variables.DH_K8S_NODE_SELECTOR_LABEL}",
      "DH_K8S_RESOURCE_LIMITS_CPU": "${blueprint.self.variables.DH_K8S_RESOURCE_LIMITS_CPU}",
      "DH_K8S_RESOURCE_LIMITS_MEMORY": "${blueprint.self.variables.DH_K8S_RESOURCE_LIMITS_MEMORY}",
      "DH_K8S_RESOURCE_REQUESTS_CPU": "${blueprint.self.variables.DH_K8S_RESOURCE_REQUESTS_CPU}",
      "DH_K8S_RESOURCE_REQUESTS_MEMORY": "${blueprint.self.variables.DH_K8S_RESOURCE_REQUESTS_MEMORY}",
      "ENV": "${blueprint.self.variables.ENV}",
      "LOG_LEVEL": "${blueprint.self.variables.LOG_LEVEL}",
      "METRICS_FETCH_DAYS_TO_PULL": "${blueprint.self.variables.METRICS_FETCH_DAYS_TO_PULL}",
      "METRICS_FETCH_EXTENDED_DAYS_TO_PULL": "${blueprint.self.variables.METRICS_FETCH_EXTENDED_DAYS_TO_PULL}",
      "METRIC_CONCURRENCY_WORKER_COUNT": "${blueprint.self.variables.METRIC_CONCURRENCY_WORKER_COUNT}",
      "METRIC_INSERT_BATCH_SIZE": "${blueprint.self.variables.METRIC_INSERT_BATCH_SIZE}",
      "REPLICA_DB_HOST": "${postgres.dagster-db.out.interfaces.reader.host}",
      "REPLICA_DB_PORT": "${postgres.dagster-db.out.interfaces.reader.port}",
      "RESOURCE_INSERT_BATCH_SIZE": "${blueprint.self.variables.RESOURCE_INSERT_BATCH_SIZE}",
      "SERVER_PORT": "${blueprint.self.variables.SERVER_PORT}",
      "STEAMPIPE_DB_HOST": "${blueprint.self.variables.STEAMPIPE_DB_HOST}",
      "STEAMPIPE_DB_MAX_IDLE_CONNS": "${blueprint.self.variables.STEAMPIPE_DB_MAX_IDLE_CONNS}",
      "STEAMPIPE_DB_MAX_IDLE_TIME_IN_SEC": "${blueprint.self.variables.STEAMPIPE_DB_MAX_IDLE_TIME_IN_SEC}",
      "STEAMPIPE_DB_MAX_LIFE_TIME_IN_SEC": "${blueprint.self.variables.STEAMPIPE_DB_MAX_LIFE_TIME_IN_SEC}",
      "STEAMPIPE_DB_MAX_OPEN_CONNS": "${blueprint.self.variables.STEAMPIPE_DB_MAX_OPEN_CONNS}",
      "STEAMPIPE_DB_NAME": "${blueprint.self.variables.STEAMPIPE_DB_NAME}",
      "STEAMPIPE_DB_PASSWORD": "${blueprint.self.secrets.STEAMPIPE_DB_PASSWORD}",
      "STEAMPIPE_DB_PORT": "${blueprint.self.variables.STEAMPIPE_DB_PORT}",
      "STEAMPIPE_DB_USERNAME": "${blueprint.self.variables.STEAMPIPE_DB_USERNAME}",
      "STEAMPIPE_PROFILE": "${blueprint.self.variables.STEAMPIPE_PROFILE}",
      "STEAMPIPE_QUERY_TIMEOUT_IN_MIN": "${blueprint.self.variables.STEAMPIPE_QUERY_TIMEOUT_IN_MIN}",
      "TENANT_DB_MAX_IDLE_CONNS": "${blueprint.self.variables.TENANT_DB_MAX_IDLE_CONNS}",
      "TENANT_DB_MAX_OPEN_CONNS": "${blueprint.self.variables.TENANT_DB_MAX_OPEN_CONNS}",
      "TENANT_SERVICE_SECRET_TOKEN": "${blueprint.self.secrets.ONELENS_BACKEND_API_SECRET_TOKEN}",
      "TENANT_SERVICE_TIMEOUT": "${blueprint.self.variables.TENANT_SERVICE_TIMEOUT}",
      "TENANT_SERVICE_URL": "http://${service.onelens-backend.out.interfaces.http.host}:${service.onelens-backend.out.interfaces.http.port}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-data-harvest}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "args": [
        "./startup-script.sh"
      ],
      "autoscaling": {
        "max": 1,
        "min": 1
      },
      "command": [
        "sh",
        "-c"
      ],
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None"
      },
      "ports": {
        "http": {
          "port": "8000",
          "protocol": "tcp",
          "service_port": "8000"
        }
      },
      "size": {
        "cpu": "1024m",
        "memory": "2Gi"
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onelens-backend

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "k8s",
  "kind": "service",
  "metadata": {
    "annotations": {},
    "labels": {
      "app": "onelens-backend",
      "component": "onelens-backend",
      "environment": "prod",
      "module": "core-platform",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onelens-backend",
    "namespace": "dagster"
  },
  "spec": {
    "enable_host_anti_affinity": false,
    "env": {
      "ANOMALY_DB_SCHEMA": "${blueprint.self.variables.ANOMALY_DB_SCHEMA}",
      "APP_HOST": "${blueprint.self.variables.APP_HOST}",
      "APP_NAME": "${blueprint.self.variables.APP_NAME}",
      "APP_PORT": "${blueprint.self.variables.APP_PORT}",
      "APP_VERSION": "${blueprint.self.variables.APP_VERSION}",
      "AUDIT_DB_SCHEMA": "${blueprint.self.variables.AUDIT_DB_SCHEMA}",
      "AUTH0_ALGORITHMS": "${blueprint.self.variables.AUTH0_ALGORITHMS}",
      "AUTH0_API_AUDIENCE": "${blueprint.self.variables.AUTH0_API_AUDIENCE}",
      "AUTH0_DOMAIN": "${blueprint.self.variables.AUTH0_DOMAIN}",
      "AUTH0_ISSUER": "${blueprint.self.variables.AUTH0_ISSUER}",
      "AUTH0_M2M_APP_CLIENT_ID": "${blueprint.self.variables.AUTH0_M2M_APP_CLIENT_ID}",
      "AUTH0_M2M_APP_CLIENT_SECRET": "${blueprint.self.secrets.AUTH0_M2M_APP_CLIENT_SECRET}",
      "AUTH0_MGMT_API_AUDIENCE": "${blueprint.self.variables.AUTH0_MGMT_API_AUDIENCE}",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "AZURE_API_VERSION": "${blueprint.self.variables.AZURE_API_VERSION}",
      "AZURE_OPENAI_API_KEY": "${blueprint.self.secrets.AZURE_OPENAI_API_KEY}",
      "AZURE_OPENAI_ENDPOINT": "${blueprint.self.variables.AZURE_OPENAI_ENDPOINT}",
      "CHANGE_MANAGER_API": "${ingress.public-nlb-ingress.out.interfaces.onyx-app_onyx-request-processor-api.connection_string}",
      "CHANGE_MANAGER_SECRET": "${blueprint.self.secrets.CHANGE_MANAGER_SECRET}",
      "DATA_RETRIEVER_SECRET": "${blueprint.self.secrets.DATA_RETRIEVER_SECRET}",
      "DATA_RETRIEVER_URL": "${blueprint.self.variables.DATA_RETRIEVER_URL}",
      "DELTA_EVENTS_DB_SCHEMA": "${blueprint.self.variables.DELTA_EVENTS_DB_SCHEMA}",
      "DEPLOYMENT_REGION": "${blueprint.self.variables.DEPLOYMENT_REGION}",
      "DEV_ENV": "${blueprint.self.variables.DEV_ENV}",
      "ENV": "${blueprint.self.variables.ENV}",
      "EXPORT_S3_BUCKET": "${s3.onelens-downloads.out.attributes.bucket_name}",
      "GH_TOKEN": "${blueprint.self.secrets.GH_TOKEN}",
      "GOOGLE_APPLICATION_CREDENTIALS": "${blueprint.self.secrets.GOOGLE_APPLICATION_CREDENTIALS}",
      "GOOGLE_CLOUD_PROJECT_CLAUDE_3_5_SONNET": "${blueprint.self.variables.GOOGLE_CLOUD_PROJECT_CLAUDE_3_5_SONNET}",
      "GOOGLE_CLOUD_REGION_CLAUDE_3_5_SONNET": "${blueprint.self.variables.GOOGLE_CLOUD_REGION_CLAUDE_3_5_SONNET}",
      "GOOGLE_GEMINI_API_KEY": "${blueprint.self.secrets.GOOGLE_GEMINI_API_KEY}",
      "KMS_KEY": "${kms.onelens-key.out.attributes.kms_key_id}",
      "KUBERNETES_DB_SCHEMA": "${blueprint.self.variables.KUBERNETES_DB_SCHEMA}",
      "KUBERNETES_S3_BUCKET_NAME": "${s3.kubernetes-s3-bucket.out.attributes.bucket_name}",
      "KUBERNETES_S3_URL_EXPIRY": "${blueprint.self.variables.KUBERNETES_S3_URL_EXPIRY}",
      "LLAMA_3_1_400B_ENDPOINT": "${blueprint.self.variables.LLAMA_3_1_400B_ENDPOINT}",
      "LLAMA_3_1_400B_PROJECT_ID": "${blueprint.self.variables.LLAMA_3_1_400B_PROJECT_ID}",
      "LLAMA_3_1_400B_REGION": "${blueprint.self.variables.LLAMA_3_1_400B_REGION}",
      "MAXIMUM_TICKET_NOTE_LENGTH": "${blueprint.self.variables.MAXIMUM_TICKET_NOTE_LENGTH}",
      "MEMGRAPH_DB_PASSWORD": "dummy-value",
      "MEMGRAPH_DB_URL": "dummy-value",
      "MEMGRAPH_DB_USER": "dummy-value",
      "NAVIRA_DB_SCHEMA": "${blueprint.self.variables.NAVIRA_DB_SCHEMA}",
      "NOTIFICATION_BUCKET": "${s3.onyx-workflow.out.attributes.bucket_name}",
      "NOTIFICATION_TOPIC": "${sns.onyx-workflow-trigger.out.attributes.topic_arn}",
      "OLBackendNewRelicKey": "${blueprint.self.secrets.OLBackendNewRelicKey}",
      "ONELENS_API_URL": "https://${ingress.public-ingress.out.interfaces.facets_ingress-onelens-backend.host}",
      "OPIK_API_KEY": "${blueprint.self.secrets.OPIK_API_KEY}",
      "OPIK_WORKSPACE": "${blueprint.self.variables.OPIK_WORKSPACE}",
      "ORG_DB_SCHEMA": "${blueprint.self.variables.ORG_DB_SCHEMA}",
      "POLICY_DB_SCHEMA": "${blueprint.self.variables.POLICY_DB_SCHEMA}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/${blueprint.self.variables.ONELENS_DB_NAME}",
      "REASONING_AZURE_API_VERSION": "${blueprint.self.variables.REASONING_AZURE_API_VERSION}",
      "REASONING_AZURE_OPENAI_API_KEY": "${blueprint.self.secrets.REASONING_AZURE_OPENAI_API_KEY}",
      "REASONING_AZURE_OPENAI_ENDPOINT": "${blueprint.self.variables.REASONING_AZURE_OPENAI_ENDPOINT}",
      "SECRET_TOKEN": "${blueprint.self.secrets.ONELENS_BACKEND_API_SECRET_TOKEN}",
      "SUPERUSER_POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/postgres",
      "TENANT_DB_HOST": "${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}",
      "TENANT_DB_REPLICA_HOST": "${postgres.dagster-db.out.interfaces.writer.host}",
      "TENANT_DB_SCHEMA": "${blueprint.self.variables.TENANT_DB_SCHEMA}",
      "TENANT_FEATURE_DB_SCHEMA": "${blueprint.self.variables.TENANT_FEATURE_DB_SCHEMA}",
      "TENANT_METADATA_DB_SCHEMA": "${blueprint.self.variables.TENANT_METADATA_DB_SCHEMA}",
      "TENANT_METRICS_CONTROL_DB_SCHEMA": "${blueprint.self.variables.TENANT_METRICS_CONTROL_DB_SCHEMA}",
      "TENANT_S3_BUCKET_REGION": "${blueprint.self.variables.TENANT_S3_BUCKET_REGION}",
      "TEST_ENV": "${blueprint.self.variables.TEST_ENV}",
      "TICKET_DB_SCHEMA": "${blueprint.self.variables.TICKET_DB_SCHEMA}",
      "TICKET_EXPORT_S3_EXPIRATION_SECONDS": "${blueprint.self.variables.TICKET_EXPORT_S3_EXPIRATION_SECONDS}",
      "TICKET_EXPORT_S3_PATH": "${blueprint.self.variables.TICKET_EXPORT_S3_PATH}",
      "TRUTO_API_SECRET_KEY": "${blueprint.self.secrets.TRUTO_API_SECRET_KEY}",
      "TRUTO_API_URL": "${blueprint.self.variables.TRUTO_API_URL}",
      "USER_DB_SCHEMA": "${blueprint.self.variables.USER_DB_SCHEMA}",
      "recommendation_engine_db_schema": "${blueprint.self.variables.recommendation_engine_db_schema}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onelens-backend}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": "8000",
          "protocol": "tcp",
          "service_port": "8000"
        }
      },
      "size": {
        "cpu": "1",
        "cpu_limit": "2048m",
        "memory": "2Gi",
        "memory_limit": "4Gi"
      },
      "volumes": {}
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-ai-insights-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "additional_volume_mounts": [
            {
              "mountPath": "/var/run/secrets/eks.amazonaws.com/serviceaccount",
              "name": "aws-iam-token",
              "readOnly": true
            }
          ],
          "additional_volumes": [
            {
              "name": "aws-iam-token",
              "projected": {
                "sources": [
                  {
                    "serviceAccountToken": {
                      "audience": "sts.amazonaws.com",
                      "expirationSeconds": 86400,
                      "path": "token"
                    }
                  }
                ]
              }
            }
          ],
          "tolerations": {
            "arm": {
              "effect": "NoSchedule",
              "key": "kubernetes.io/arch",
              "operator": "Equal",
              "value": "arm64"
            }
          }
        }
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-ai-insights-api",
      "component": "onyx-ai-insights-api",
      "environment": "test",
      "module": "insights_core",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-ai-insights-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AI_INSIGHTS": 1,
      "APP_TITLE": "ai_insights_api",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "AWS_DEFAULT_REGION": "${blueprint.self.variables.AWS_DEFAULT_REGION}",
      "AWS_REGION": "${blueprint.self.variables.AWS_DEFAULT_REGION}",
      "AWS_ROLE_ARN": "arn:aws:iam::609916866699:role/test-onyx-ecs-task-execution-role",
      "AWS_SDK_LOAD_CONFIG": "1",
      "AWS_WEB_IDENTITY_TOKEN_FILE": "/var/run/secrets/eks.amazonaws.com/serviceaccount/token",
      "CLICKHOUSE_CONNECTION_STRING": "${blueprint.self.secrets.CLICKHOUSE_CONNECTION_STRING}",
      "CRYPT_KEY_ID": "${kms.onelens-key.out.attributes.kms_key_id}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/postgres",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-dataware-house-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/dataware_house/common/config/.env",
            "name": "${config_map.onyx-dwh.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-authentication-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-authentication-api",
      "component": "onyx-authentication-api",
      "environment": "test",
      "module": "user_management",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-authentication-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/postgres",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-authentication-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "max": 1,
        "min": 1
      },
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/authentication/common/config/.env",
            "name": "${config_map.onyx-authentication.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-cost-center-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-cost-center-api",
      "component": "onyx-cost-center-api",
      "environment": "test",
      "module": "cost-center",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-cost-center-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "CRYPT_KEY_ID": "${kms.onelens-key.out.attributes.kms_key_id}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/postgres",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-cost-center-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "max": 1,
        "min": 1
      },
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/cost_center/common/config/.env",
            "name": "${config_map.onyx-cost-center.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-cost-center-job

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "keda": {
            "triggers": {
              "sqs-trigger": {
                "metadata": {
                  "awsRegion": "${var.cluster.awsRegion}",
                  "identityOwner": "operator",
                  "queueLength": "5",
                  "queueURL": "${sqs.onyx-cur-delta.out.attributes.sqs_queue_name}"
                },
                "type": "aws-sqs-queue"
              }
            }
          }
        }
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-cost-center-job",
      "component": "onyx-cost-center-job",
      "environment": "test",
      "module": "cost-center",
      "product": "onelens",
      "purpose": "tooling",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-cost-center-job",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "CRYPT_KEY_ID": "${kms.onelens-key.out.attributes.kms_key_id}",
      "CUR_DELTA_QUEUE": "${sqs.onyx-cur-delta.out.attributes.sqs_queue_name}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/postgres",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-cost-center-job}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": 1,
        "min": 1,
        "scaling_on": "CPU"
      },
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None",
        "startup_check_type": "None"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/cost_center/common/config/.env",
            "name": "${config_map.onyx-cost-center.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "uiProps": {},
  "version": "0.1"
}
```

---

## service/onyx-dashboard-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-dashboard-api",
      "component": "onyx-dashboard-api",
      "environment": "test",
      "module": "dashboard",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-dashboard-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "CRYPT_KEY_ID": "${kms.onelens-key.out.attributes.kms_key_id}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/postgres",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-dashboard-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "max": 1,
        "min": 1
      },
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/dashboard/common/config/.env",
            "name": "${config_map.onyx-dashboard.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-dataware-house-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-dataware-house-api",
      "component": "onyx-dataware-house-api",
      "environment": "test",
      "module": "data-warehouse",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-dataware-house-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "APP_TITLE": "dataware_house_api",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "CLICKHOUSE_CONNECTION_STRING": "${blueprint.self.secrets.CLICKHOUSE_CONNECTION_STRING}",
      "CRYPT_KEY_ID": "${kms.onelens-key.out.attributes.kms_key_id}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/postgres",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-dataware-house-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/dataware_house/common/config/.env",
            "name": "${config_map.onyx-dwh.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-dataware-house-api-temp

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-dataware-house-api-temp"
    },
    "name": "onyx-dataware-house-api-temp",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "APP_TITLE": "dataware_house_api_temp",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "CLICKHOUSE_CONNECTION_STRING": "${blueprint.self.secrets.CLICKHOUSE_CONNECTION_STRING}",
      "CRYPT_KEY_ID": "${kms.onelens-key.out.attributes.kms_key_id}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/postgres",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-dataware-house-api-temp}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/dataware_house/common/config/.env",
            "name": "${config_map.onyx-dwh.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-dataware-house-job

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-dataware-house-job",
      "component": "onyx-dataware-house-job",
      "environment": "test",
      "module": "data-warehouse",
      "product": "onelens",
      "purpose": "tooling",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-dataware-house-job",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "APP_TITLE": "dataware_house_job",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "CLICKHOUSE_CONNECTION_STRING": "${blueprint.self.secrets.CLICKHOUSE_CONNECTION_STRING}",
      "CRYPT_KEY_ID": "${kms.onelens-key.out.attributes.kms_key_id}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-dataware-house-job}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/dataware_house/common/config/.env",
            "name": "${config_map.onyx-dwh.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-integrations-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-integrations-api",
      "component": "onyx-integrations-api",
      "environment": "test",
      "module": "integrations",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-integrations-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "TOKEN": "${blueprint.self.secrets.ONYX_WORKFLOW_EXECUTION_TOKEN}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-integrations-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "max": 1,
        "min": 1
      },
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/integrations/common/config/.env",
            "name": "${config_map.onyx-integrations.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-log-processor-job

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "keda": {
            "triggers": {
              "sqs-trigger": {
                "metadata": {
                  "awsRegion": "${var.cluster.awsRegion}",
                  "identityOwner": "operator",
                  "queueLength": "5",
                  "queueURL": "${sqs.onyx-log-processor.out.attributes.queue_arn}"
                },
                "type": "aws-sqs-queue"
              }
            }
          }
        }
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-log-processor-job",
      "component": "onyx-log-processor-job",
      "environment": "test",
      "module": "log-processor",
      "product": "onelens",
      "purpose": "tooling",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-log-processor-job",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "APP_TITLE": "log_processor_job",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "JOB_PURPOSE": "log_processor",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-log-processor-job}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/request_processor/common/config/.env",
            "name": "${config_map.onyx-request-proc.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-request-processor-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-request-processor-api",
      "component": "onyx-request-processor-api",
      "environment": "test",
      "module": "request-processor",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-request-processor-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "APP_TITLE": "request_processor_api",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-request-processor-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "max": 1,
        "min": 1
      },
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/request_processor/common/config/.env",
            "name": "${config_map.onyx-request-proc.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-request-processor-job

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "keda": {
            "triggers": {
              "sqs-trigger": {
                "metadata": {
                  "awsRegion": "${var.cluster.awsRegion}",
                  "identityOwner": "operator",
                  "queueLength": "5",
                  "queueURL": "${sqs.onyx-request-processor.out.attributes.queue_arn}"
                },
                "type": "aws-sqs-queue"
              }
            }
          }
        }
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-request-processor-job",
      "component": "onyx-request-processor-job",
      "environment": "test",
      "module": "request-processor",
      "product": "onelens",
      "purpose": "tooling",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-request-processor-job",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "APP_TITLE": "request_processor_job",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "JOB_PURPOSE": "request_processor",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-request-processor-job}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/request_processor/common/config/.env",
            "name": "${config_map.onyx-request-proc.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-runbooks-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-runbooks-api",
      "component": "onyx-runbooks-api",
      "environment": "test",
      "module": "runbook",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-runbooks-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "TOKEN": "${blueprint.self.secrets.ONYX_WORKFLOW_EXECUTION_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-runbooks-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "runbooks-api-config": {
            "mount_path": "/runbooks/common/config/.env",
            "name": "${config_map.runbooks-api-config.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-scheduler-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "additional_volume_mounts": [
            {
              "mountPath": "/var/run/secrets/eks.amazonaws.com/serviceaccount",
              "name": "aws-iam-token",
              "readOnly": true
            }
          ],
          "additional_volumes": [
            {
              "name": "aws-iam-token",
              "projected": {
                "sources": [
                  {
                    "serviceAccountToken": {
                      "audience": "sts.amazonaws.com",
                      "expirationSeconds": 86400,
                      "path": "token"
                    }
                  }
                ]
              }
            }
          ],
          "nodeSelector": {
            "kubernetes.io/arch": "amd64"
          },
          "tolerations": {
            "amd": {
              "effect": "NoSchedule",
              "key": "kubernetes.io/arch",
              "operator": "Equal",
              "value": "amd64"
            }
          }
        }
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-scheduler-api",
      "component": "onyx-scheduler-api",
      "environment": "test",
      "module": "scheduler",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-scheduler-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "AWS_DEFAULT_REGION": "${blueprint.self.variables.AWS_DEFAULT_REGION}",
      "AWS_REGION": "${blueprint.self.variables.AWS_DEFAULT_REGION}",
      "AWS_ROLE_ARN": "arn:aws:iam::609916866699:role/test-onyx-ecs-task-execution-role",
      "AWS_SDK_LOAD_CONFIG": "1",
      "AWS_WEB_IDENTITY_TOKEN_FILE": "/var/run/secrets/eks.amazonaws.com/serviceaccount/token",
      "CRYPT_KEY_ID": "${kms.onelens-key.out.attributes.kms_key_id}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/postgres",
      "SCHEDULER_SQS_URL": "https://sqs.ap-southeast-1.amazonaws.com/609916866699/onelens-scheduler-requests-queue.fifo",
      "TOKEN": "${blueprint.self.secrets.ONYX_WORKFLOW_EXECUTION_TOKEN}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-scheduler-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "max": 1,
        "min": 1
      },
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/scheduler/common/config/.env",
            "name": "${config_map.onyx-scheduler.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-workflow-actions-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-workflow-actions-api",
      "component": "onyx-workflow-actions-api",
      "environment": "test",
      "module": "workflow",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-workflow-actions-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "TOKEN": "${blueprint.self.secrets.ONYX_WORKFLOW_EXECUTION_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-workflow-actions-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/workflow_actions/common/config/.env",
            "name": "${config_map.onyx-wf-actions.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-workflow-cron-job

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "keda": {
            "triggers": {
              "sqs-trigger": {
                "metadata": {
                  "awsRegion": "${var.cluster.awsRegion}",
                  "identityOwner": "operator",
                  "queueLength": "5",
                  "queueURL": "${sqs.onyx-workflow-cron.out.attributes.queue_arn}"
                },
                "type": "aws-sqs-queue"
              }
            }
          }
        }
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-workflow-cron-job",
      "component": "onyx-workflow-cron-job",
      "environment": "test",
      "module": "workflow",
      "product": "onelens",
      "purpose": "tooling",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-workflow-cron-job",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "APP_TITLE": "workflow_cron_job",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "JOB_PURPOSE": "cron",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "TOKEN": "${blueprint.self.secrets.ONYX_WORKFLOW_EXECUTION_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-workflow-cron-job}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/workflow_execution/common/config/.env",
            "name": "${config_map.onyx-wf-execution.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-workflow-execution-job

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "keda": {
            "triggers": {
              "sqs-trigger": {
                "metadata": {
                  "awsRegion": "${var.cluster.awsRegion}",
                  "identityOwner": "operator",
                  "queueLength": "5",
                  "queueURL": "${sqs.onyx-workflow-execution.out.attributes.queue_arn} "
                },
                "type": "aws-sqs-queue"
              }
            }
          }
        }
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-workflow-execution-job",
      "component": "onyx-workflow-execution-job",
      "environment": "test",
      "module": "workflow",
      "product": "onelens",
      "purpose": "tooling",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-workflow-execution-job",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "APP_TITLE": "workflow_execution_job",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "JOB_PURPOSE": "execution",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "TOKEN": "${blueprint.self.secrets.ONYX_WORKFLOW_EXECUTION_TOKEN}"
    },
    "release": {
      "disruption_policy": {},
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-workflow-execution-job}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": "1",
        "min": "1"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/workflow_execution/common/config/.env",
            "name": "${config_map.onyx-wf-execution.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-workflow-mgmt-api

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {}
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-workflow-mgmt-api",
      "component": "onyx-workflow-mgmt-api",
      "environment": "test",
      "module": "workflow",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-workflow-mgmt-api",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "TOKEN": "${blueprint.self.secrets.ONYX_WORKFLOW_EXECUTION_TOKEN}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-workflow-mgmt-api}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "max": 1,
        "min": 1
      },
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/workflow_management/common/config/.env",
            "name": "${config_map.onyx-wf-mgmt.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

## service/onyx-workflow-trigger-job

```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "keda": {
            "triggers": {
              "sqs-trigger": {
                "metadata": {
                  "awsRegion": "${var.cluster.awsRegion}",
                  "identityOwner": "operator",
                  "queueLength": "5",
                  "queueURL": "${sqs.onyx-workflow-trigger.out.attributes.queue_arn}"
                },
                "type": "aws-sqs-queue"
              }
            }
          }
        }
      }
    }
  },
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.onyx-role.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "app": "onyx-workflow-trigger-job",
      "component": "onyx-workflow-trigger-job",
      "environment": "test",
      "module": "workflow",
      "product": "onelens",
      "purpose": "tooling",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "onyx-workflow-trigger-job",
    "namespace": "onyx"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": true,
        "iam_policies": {
          "iam-policies2": {
            "arn": "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
          }
        }
      },
      "gcp": {
        "roles": {
          "gcp-role1": {
            "role": "roles/pubsub.viewer"
          }
        }
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "APP_TITLE": "workflow_trigger_job",
      "AUTH_API_KEY": "${blueprint.self.secrets.AUTH_API_KEY}",
      "AUTH_URL": "${blueprint.self.variables.AUTH_URL}",
      "EXTERNAL_PROVIDER_API_TOKEN": "${blueprint.self.secrets.EXTERNAL_PROVIDER_API_TOKEN}",
      "Environment": "${blueprint.self.variables.ENV}",
      "JOB_PURPOSE": "trigger",
      "OL_TOKEN": "${blueprint.self.secrets.OL_TOKEN}",
      "ONYX_API_TOKEN": "${blueprint.self.secrets.ONYX_API_TOKEN}",
      "TOKEN": "${blueprint.self.secrets.ONYX_WORKFLOW_EXECUTION_TOKEN}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-onyx-workflow-trigger-job}",
      "image_pull_policy": "Always",
      "strategy": {
        "max_available": "25%",
        "max_unavailable": "25%",
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "autoscaling": {
        "cpu_threshold": "50",
        "max": 1,
        "min": 1,
        "scaling_on": "CPU"
      },
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None",
        "startup_check_type": "None"
      },
      "ports": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "service_port": 80
        }
      },
      "size": {
        "cpu": "500m",
        "cpu_limit": "1500m",
        "memory": "1Gi",
        "memory_limit": "5Gi"
      },
      "volumes": {
        "config_maps": {
          "config-maps1": {
            "mount_path": "/workflow_execution/common/config/.env",
            "name": "${config_map.onyx-wf-execution.out.attributes.name}",
            "sub_path": ".env"
          }
        }
      }
    },
    "type": "application"
  },
  "uiProps": {},
  "version": "0.1"
}
```

---

## service/policy-master-tool

```json
{
  "disabled": false,
  "flavor": "deployment",
  "kind": "service",
  "metadata": {
    "annotations": {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.full-services-access.out.attributes.irsa_iam_role_arn}"
    },
    "labels": {
      "component": "policy-master-tool",
      "deliveryType": "MANUAL",
      "environment": "test",
      "module": "pmt",
      "product": "onelens",
      "purpose": "application",
      "resource-type": "service",
      "shared": "true"
    },
    "name": "policy-master-tool",
    "namespace": "dagster"
  },
  "spec": {
    "cloud_permissions": {
      "aws": {
        "enable_irsa": false
      }
    },
    "enable_host_anti_affinity": false,
    "env": {
      "AUTH_USER_CREDENTIALS": "${blueprint.self.secrets.AUTH_USER_CREDENTIALS}",
      "AZURE_API_VERSION": "${blueprint.self.variables.AZURE_API_VERSION}",
      "AZURE_OPENAI_API_KEY": "${blueprint.self.secrets.AZURE_OPENAI_API_KEY}",
      "AZURE_OPENAI_ENDPOINT": "${blueprint.self.variables.AZURE_OPENAI_ENDPOINT}",
      "COOKIE_EXPIRY_DAYS": "${blueprint.self.variables.COOKIE_EXPIRY_DAYS}",
      "COOKIE_KEY": "${blueprint.self.secrets.COOKIE_KEY}",
      "COOKIE_NAME": "${blueprint.self.variables.COOKIE_NAME}",
      "ENV": "${blueprint.self.variables.ENV}",
      "GOOGLE_APPLICATION_CREDENTIALS": "${blueprint.self.secrets.GOOGLE_APPLICATION_CREDENTIALS}",
      "GOOGLE_CLOUD_PROJECT_CLAUDE_3_5_SONNET": "${blueprint.self.variables.GOOGLE_CLOUD_PROJECT_CLAUDE_3_5_SONNET}",
      "GOOGLE_CLOUD_REGION_CLAUDE_3_5_SONNET": "${blueprint.self.variables.GOOGLE_CLOUD_REGION_CLAUDE_3_5_SONNET}",
      "GOOGLE_GEMINI_API_KEY": "${blueprint.self.secrets.GOOGLE_GEMINI_API_KEY}",
      "KMS_KEY": "${kms.onelens-key.out.attributes.kms_key_id}",
      "LLAMA_3_1_400B_ENDPOINT": "${blueprint.self.variables.LLAMA_3_1_400B_ENDPOINT}",
      "LLAMA_3_1_400B_PROJECT_ID": "${blueprint.self.variables.LLAMA_3_1_400B_PROJECT_ID}",
      "LLAMA_3_1_400B_REGION": "${blueprint.self.variables.LLAMA_3_1_400B_REGION}",
      "LOG_LEVEL": "INFO",
      "MEMGRAPH_DB_PASSWORD": "${blueprint.self.secrets.MEMGRAPH_DB_PASSWORD}",
      "MEMGRAPH_DB_URL": "bolt://${deleted}:7687",
      "MEMGRAPH_DB_USER": "${blueprint.self.variables.MEMGRAPH_DB_USER}",
      "ONELENS_BACKEND_API_SECRET_TOKEN": "${blueprint.self.secrets.ONELENS_BACKEND_API_SECRET_TOKEN}",
      "ONELENS_BACKEND_API_URL": "${ingress.public-ingress.out.interfaces.facets_ingress-onelens-backend.host}",
      "POSTGRES_CONNECTION_STRING": "postgresql://${postgres.dagster-db.out.interfaces.writer.username}:${postgres.dagster-db.out.interfaces.writer.password}@${postgres.dagster-db.out.interfaces.writer.host}:${postgres.dagster-db.out.interfaces.writer.port}/${blueprint.self.variables.ONELENS_DB_NAME}",
      "WEB_SEARCH_API_URL": "http://${deleted}:${deleted}"
    },
    "release": {
      "image": "${blueprint.self.artifacts.onelens-4786099461-policy-master-tool}",
      "image_pull_policy": "Always",
      "strategy": {
        "type": "RollingUpdate"
      }
    },
    "restart_policy": "Always",
    "runtime": {
      "args": [],
      "autoscaling": {
        "cpu_threshold": "50",
        "max": 1,
        "min": 1,
        "scaling_on": "CPU"
      },
      "command": [],
      "health_checks": {
        "liveness_check_type": "None",
        "readiness_check_type": "None"
      },
      "ports": {
        "ports1": {
          "port": "8502",
          "protocol": "tcp",
          "service_port": "8502"
        }
      },
      "size": {
        "cpu": "300m",
        "memory": "1Gi"
      }
    },
    "type": "application"
  },
  "version": "0.1"
}
```

---

# sns

## sns/onyx-notification

```json
{
  "disabled": false,
  "flavor": "default",
  "kind": "sns",
  "metadata": {
    "name": "onyx-notification"
  },
  "spec": {
    "disable_encryption": false,
    "subscriptions": {
      "sqs": {
        "endpoint": "${sqs.onyx-log-processor.out.attributes.queue_arn}",
        "protocol": "sqs",
        "raw_message_delivery": true
      },
      "subscriptions1": {
        "endpoint": "${sqs.onyx-request-processor.out.attributes.queue_arn}",
        "protocol": "sqs",
        "raw_message_delivery": true
      }
    }
  },
  "version": "0.1"
}
```

---

## sns/onyx-workflow-execution

```json
{
  "disabled": false,
  "flavor": "default",
  "kind": "sns",
  "metadata": {
    "name": "onyx-workflow-execution"
  },
  "spec": {
    "disable_encryption": false,
    "subscriptions": {
      "sqs": {
        "endpoint": "${sqs.onyx-workflow-execution.out.attributes.queue_arn}",
        "protocol": "sqs",
        "raw_message_delivery": true
      }
    }
  },
  "version": "0.1"
}
```

---

## sns/onyx-workflow-trigger

```json
{
  "disabled": false,
  "flavor": "default",
  "kind": "sns",
  "metadata": {
    "name": "onyx-workflow-trigger"
  },
  "spec": {
    "disable_encryption": false,
    "subscriptions": {
      "sqs": {
        "endpoint": "${sqs.onyx-workflow-cron.out.attributes.queue_arn}",
        "protocol": "sqs",
        "raw_message_delivery": true
      },
      "subscriptions1": {
        "endpoint": "${sqs.onyx-workflow-trigger.out.attributes.queue_arn}",
        "protocol": "sqs",
        "raw_message_delivery": true
      }
    }
  },
  "version": "0.1"
}
```

---

# sqs

## sqs/olschedulerdlq

```json
{
  "advanced": {
    "sqs": {
      "tags": {
        "Module": "Scheduler",
        "Project": "Onyx",
        "Type": "FIFO"
      }
    }
  },
  "disabled": false,
  "flavor": "default",
  "kind": "sqs",
  "metadata": {
    "name": "olschedulerdlq"
  },
  "spec": {
    "content_based_deduplication": true,
    "fifo_queue": true,
    "message_retention_seconds": 1209600,
    "use_sqs_managed_sse": false,
    "visibility_timeout_seconds": 900
  },
  "uiProps": {},
  "version": "0.2"
}
```

---

## sqs/onyx-log-processor

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/sqs/sqs.schema.json",
  "disabled": false,
  "flavor": "default",
  "kind": "sqs",
  "metadata": {
    "name": "onyx-log-processor"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## sqs/onyx-orchestrator

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/sqs/sqs.schema.json",
  "disabled": false,
  "flavor": "default",
  "kind": "sqs",
  "metadata": {
    "name": "onyx-orchestrator"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## sqs/onyx-request-processor

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/sqs/sqs.schema.json",
  "disabled": false,
  "flavor": "default",
  "kind": "sqs",
  "metadata": {
    "name": "onyx-request-processor"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## sqs/onyx-workflow-cron

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/sqs/sqs.schema.json",
  "disabled": false,
  "flavor": "default",
  "kind": "sqs",
  "metadata": {
    "name": "onyx-workflow-cron"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## sqs/onyx-workflow-dlq

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/sqs/sqs.schema.json",
  "disabled": false,
  "flavor": "default",
  "kind": "sqs",
  "metadata": {
    "name": "onyx-workflow-dlq"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## sqs/onyx-workflow-execution

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/sqs/sqs.schema.json",
  "disabled": false,
  "flavor": "default",
  "kind": "sqs",
  "metadata": {
    "name": "onyx-workflow-execution"
  },
  "spec": {},
  "version": "0.2"
}
```

---

## sqs/onyx-workflow-trigger

```json
{
  "$schema": "https://facets-cloud.github.io/facets-schemas/schemas/sqs/sqs.schema.json",
  "disabled": false,
  "flavor": "default",
  "kind": "sqs",
  "metadata": {
    "name": "onyx-workflow-trigger"
  },
  "spec": {},
  "version": "0.2"
}
```

---

