OTEL_VERSION ?= 0.98.0

clean:
	@rm -rf githubactionslogreceiver

githubactionslogreceiver: clean
	@cp -r ../../opentelemetry-collector-contrib/receiver/githubactionslogreceiver ./githubactionslogreceiver

build: githubactionslogreceiver
	@test -n "$(COMMIT)" || (echo "COMMIT is not set"; exit 1)
	@docker build --build-arg="OTEL_VERSION=$(OTEL_VERSION)" -t otelcol-custom:$(OTEL_VERSION)-githubactionslogreceiver-$(COMMIT) .
