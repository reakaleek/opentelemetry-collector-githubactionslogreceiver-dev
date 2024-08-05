# OpenTelemetry Collector GitHub Actions Helm Chart

A custom OpenTelemetry Collector Helm chart for GitHub Actions logs.

## Parameters

### Ingress configuration

| Name           | Description                                 | Value                                                                                                         |
| -------------- | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `host`         | The hostname of the OpenTelemetry Collector | `otelcol-github-actions.elastic.dev`                                                                          |
| `ip.whitelist` | The IP whitelist for the Ingress            | `["192.30.252.0/22","185.199.108.0/22","140.82.112.0/20","143.55.64.0/20","2a0a:a440::/29","2606:50c0::/32"]` |

### Image configuration

| Name               | Description                       | Value                                                              |
| ------------------ | --------------------------------- | ------------------------------------------------------------------ |
| `image.repository` | The image repository to pull from | `reakaleek/otelcol-custom@sha256`                                  |
| `image.tag`        | The image tag to pull             | `b327730c7acb2570569c744a88649fdb19925322ce3e4f8fac300ff01dd2f983` |
| `image.pullPolicy` | The image pull policy             | `IfNotPresent`                                                     |

### Replica count configuration

| Name           | Description                   | Value |
| -------------- | ----------------------------- | ----- |
| `replicaCount` | The number of replicas to run | `2`   |

### Resources configuration

| Name        | Description                                | Value |
| ----------- | ------------------------------------------ | ----- |
| `resources` | The resources to allocate to the container | `{}`  |

### Extra environment variables

| Name                | Description                           | Value        |
| ------------------- | ------------------------------------- | ------------ |
| `extraEnv[0].name`  | The name of the environment variable  | `GOMEMLIMIT` |
| `extraEnv[0].value` | The value of the environment variable | `380MiB`     |

### Service account configuration

| Name                         | Description                         | Value |
| ---------------------------- | ----------------------------------- | ----- |
| `serviceAccount.annotations` | Annotations for the service account | `{}`  |

### OpenTelemetry Collector onfiguration

| Name               | Description                                       | Value |
| ------------------ | ------------------------------------------------- | ----- |
| `collector.config` | The configuration for the OpenTelemetry Collector | `{}`  |
