OTEL_VERSION ?= 0.102.0

clean:
	@rm -rf githubactionslogreceiver

githubactionslogreceiver: clean
	@cp -r ../../opentelemetry-collector-contrib/receiver/githubactionslogreceiver ./githubactionslogreceiver

githubactionsannotationsreceiver:
	@cp -r ../../opentelemetry-github-actions-annotations-receiver ./githubactionsannotationsreceiver

build: githubactionslogreceiver githubactionsannotationsreceiver
	@test -n "$(COMMIT)" || (echo "COMMIT is not set"; exit 1)
	@docker build --build-arg="OTEL_VERSION=$(OTEL_VERSION)" -t otelcol-custom:$(OTEL_VERSION)-githubactionslogreceiver-$(COMMIT) .
