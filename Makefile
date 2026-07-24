.DEFAULT_GOAL := help

.PHONY: import publish all clean verify help

# Load environment variables (only for Makefile)
include project.conf

# Export host UID/GID so the container writes artifacts as the current user
export DOCKER_UID := $(shell id -u)
export DOCKER_GID := $(shell id -g)

# Path to your Compose file and environment file
COMPOSE_FILE = .docker/docker-compose.yaml

# Base Docker Compose command
DC = docker compose -p $(KEYSTONE_DOCKER_COMPOSE_PROJECT) --file $(COMPOSE_FILE) --env-file project.conf

# Base import command
IMPORT = $(DC) run --rm keystone ./.pandoc/import.sh

# Base publish command
#
# `using=<name>` selects a build configuration (a named symbol set declared in
# project.conf as KEYSTONE_DEFINE_<name>) for conditional inclusion. It is
# forwarded as an env override so it wins over the project.conf default, and it
# also suffixes the output filename so editions don't clobber each other.
#
# `strict=true|false` overrides KEYSTONE_WARNINGS_AS_ERRORS the same way: any
# value is forwarded as an env override and wins over the project.conf default,
# so CI can run `make publish strict=true` without editing project.conf.
PUBLISH = $(DC) run --rm \
    $(if $(using),-e KEYSTONE_USING=$(using)) \
    $(if $(strict),-e KEYSTONE_WARNINGS_AS_ERRORS=$(strict)) \
    keystone ./.pandoc/publish.sh

# Defaults
format ?= pdf

# Import a document (DOCX, ODT, RTF, HTML, etc.) from the `./artifacts` folder
# Usage: make import artifact=chapter1.docx
import:
	@if [ -z "$(artifact)" ]; then \
		echo "ERROR: Please provide an artifact filename from the artifacts folder, e.g., make import artifact=chapter1.docx" >&2; \
		exit 1; \
	fi
	@$(IMPORT) "$(artifact)"
	@echo ""
	@echo "Next steps:"
	@echo "  • Review your ./artifacts folder and move imported content to:"
	@echo "    → ./manuscript — to store chapters and appendices"
	@echo "    → ./assets     — to store images and other assets"
	@echo ""
	@echo "Tip: Keeping one file per chapter or section is ideal for clarity and maintainability"
	@echo ""
	@echo "Edit your Markdown files:"
	@echo "  • Adjust headings and subheadings as needed"
	@echo "  • Update to keep one file per chapter or section"
	@echo "  • Update image paths to use ./assets where applicable"
	@echo ""
	@echo "Finally, update publish.txt to include the new files in the desired order"
	@echo ""

# Publish a specific output (PDF or EPUB)
# Usage: make publish [format=pdf|epub] [using=<config>] [strict=true|false]
publish:
	@$(PUBLISH) $(format)

# Build all supported formats
all:
	@$(PUBLISH) pdf
	@$(PUBLISH) epub
	@$(PUBLISH) docx

# Clean up build artifacts
clean:
	@echo "Removing generated artifacts..." \
		&& rm -rf ./artifacts

# Verify the Keystone Docker image signature
verify:
	@docker run --rm ghcr.io/sigstore/cosign/cosign:v3.1.2@sha256:d91bc4e7e95e8d2f549c747a72dc174f90579e410a1695f57f686674f84ce849 verify \
		ghcr.io/knight-owl-dev/keystone:v2.2.4 \
		--certificate-oidc-issuer https://token.actions.githubusercontent.com \
		--certificate-identity-regexp '^https://github\.com/knight-owl-dev/keystone/'

# Show help message
help:
	@echo ""
	@echo "Keystone Build Commands:"
	@echo "  make publish [format=pdf|epub|docx] [using=<config>]   Build a specific format (default: pdf)"
	@echo "  make import artifact=input-file.ext                Import a document (DOCX, ODT, RTF) from ./artifacts"
	@echo "  make all                                           Build all supported formats (PDF, EPUB, DOCX)"
	@echo "  make clean                                         Delete generated artifacts from ./artifacts"
	@echo "  make verify                                        Verify the Docker image signature"
	@echo "  make help                                          Show this message"
	@echo ""
