# The names must be the same name as the 'receivers[*].path' in the builder-config.yml without the `./` prefix
ARG LOGS_RECEIVER_NAME=githubactionslogsreceiver
ARG TRACES_RECEIVER_NAME=githubactionstracesreceiver
ARG ANNOTATIONS_RECEIVER_NAME=githubactionsannotationsreceiver

FROM alpine/git AS clone
ARG LOGS_RECEIVER_NAME
ARG TRACES_RECEIVER_NAME
ARG ANNOTATIONS_RECEIVER_NAME

ARG LOGS_RECEIVER_CLONE_URL="https://github.com/v1v/opentelemetry-github-actions-log-receiver.git"
ARG TRACES_RECEIVER_CLONE_URL="https://github.com/v1v/opentelemetry-github-actions-receiver.git"
ARG ANNOTATIONS_RECEIVER_CLONE_URL="https://github.com/v1v/opentelemetry-github-actions-annotations-receiver.git"

RUN git clone "$LOGS_RECEIVER_CLONE_URL" "$LOGS_RECEIVER_NAME"
RUN git clone "$TRACES_RECEIVER_CLONE_URL" "$TRACES_RECEIVER_NAME"
RUN git clone "$ANNOTATIONS_RECEIVER_CLONE_URL" "$ANNOTATIONS_RECEIVER_NAME"

FROM golang:1.23 AS build
ARG LOGS_RECEIVER_NAME
ARG TRACES_RECEIVER_NAME
ARG ANNOTATIONS_RECEIVER_NAME
WORKDIR /app
COPY ./builder-config.yml .
RUN apt-get update && apt-get install yq -y --no-install-recommends
RUN yq -r '.dist.otel_version' builder-config.yml > .otel_version
RUN go install go.opentelemetry.io/collector/cmd/builder@v$(cat .otel_version)
COPY --from=clone /git/"$LOGS_RECEIVER_NAME" ./"$LOGS_RECEIVER_NAME"
COPY --from=clone /git/"$TRACES_RECEIVER_NAME" ./"$TRACES_RECEIVER_NAME"
COPY --from=clone /git/"$ANNOTATIONS_RECEIVER_NAME" ./"$ANNOTATIONS_RECEIVER_NAME"
COPY ./builder-config.yml .
RUN CGO_ENABLED=0 builder --config=builder-config.yml

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /app/bin/otelcol-custom /

EXPOSE 19418/tcp

CMD ["/otelcol-custom"]
