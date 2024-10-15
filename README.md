# GitHub Actions Log Receiver Development Environment

This repository contains the development environment for the GitHub Actions Log Receiver.

## Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- Golang 1.21 or later
- [OpenTelemetry Collector Builder](https://opentelemetry.io/docs/collector/custom-collector/)

## Getting Started
1. Clone this repository.
    ```bash
    git clone https://github.com/reakaleek/opentelemetry-collector-githubactionslogreceiver-dev.git
    ```

1. Clone the forked opentelemetry-collector-contrib repository as a sibling to this repository and checkout the branch `feature/githubactionslogsreceiver`.

    ```bash
    git clone https://github.com/reakaleek/opentelemetry-collector-contrib.git --branch feature/githubactionslogsreceiver
    ```

1. Clone the https://github.com/v1v/opentelemetry-github-actions-annotations-receiver repository as a sibling to this repository and checkout the branch `feature/send-annotations`.

    ```bash
    git clone https://github.com/v1v/opentelemetry-github-actions-annotations-receiver --branch feature/send-annotations
    cp -rf opentelemetry-github-actions-annotations-receiver opentelemetry-collector-contrib/receiver/githubactionsannotationsreceiver
    ```

1. Go to the development environment directory.

    ```bash
    cd opentelemetry-githubactions-log-receiver-dev
    ```

1. Download the OpenTelemetry Collector Builder.

   See instructions at https://opentelemetry.io/docs/collector/custom-collector/

   > Downloading the binary from the [Releases](https://github.com/open-telemetry/opentelemetry-collector/releases?q=builder) page is the recommended way to install the builder.

1. Build the OpenTelemetry Collector.

    ```bash
    ./ocb --config builder-config.yml
    ```

1. Start the OpenTelemetry Collector.

    ```bash
    GITHUB_TOKEN="<your-PAT>" go run ./otelcol-dev --config config.yml
    ```

   > Your PAT needs *read* access to "actions" to be able to download logs.

1. Start an Elastichsearch and Kibana instance.

    ```bash
    docker-compose up
    ```
1. Create a new index template.

   ```shell
   curl -X PUT "localhost:9200/_index_template/logs-github-actions" \
    -H 'Content-Type: application/json' \
    -d '{
      "index_patterns": ["logs-github-actions-*"],
      "template": {
        "mappings": {
          "properties": {
            "@timestamp": {
              "type": "date_nanos"
            }
          }
        }
      },
      "composed_of": [
        "logs@settings",
        "logs@mappings"
      ]
    }'
   ```
   
   > This index template is required to parse the `@timestamp` field as a `date_nanos` type. Otherwise, logs will be displayed in the wrong order. 

1. Create a tunnel with https://smee.io/ and start the Smee client.

    ```bash
    npx smee-client --url https://smee.io/<your-smee-id> --target http://127.0.0.1:19418/workflow-run-events
    ```

1. Add a new webhook to your repository using the Smee URL with `workflow_run` events.

1. You can now wait or trigger a workflow to see the logs in Kibana. :tada:
