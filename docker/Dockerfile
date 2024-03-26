FROM golang:1.21 as build
ARG  OTEL_VERSION
WORKDIR /app
RUN go install go.opentelemetry.io/collector/cmd/builder@v${OTEL_VERSION}
COPY . .
RUN CGO_ENABLED=0 builder --config=builder-config.yml

FROM scratch
COPY --from=build /app/bin/otelcol-custom /

EXPOSE 19418/tcp

CMD ["/otelcol-custom"]
