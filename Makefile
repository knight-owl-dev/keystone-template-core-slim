.PHONY: import publish all clean sample help

# Load environment variables (only for Makefile)
include .env

# Path to your Compose file and environment file
COMPOSE_FILE = .docker/docker-compose.yaml

# Base Docker Compose command
DC = docker compose -p $(KEYSTONE_DOCKER_COMPOSE_PROJECT) --file $(COMPOSE_FILE) --env-file .env

# Base import command
IMPORT = $(DC) run --rm keystone ./.pandoc/import.sh

# Base publish command
PUBLISH = $(DC) run --rm keystone ./.pandoc/publish.sh

# Defaults
target ?= book
format ?= pdf

# Import a document (DOCX, ODT, RTF, HTML, etc.) from the `./artifacts` folder
# Usage: make import artifact=chapter1.docx
import:
	@if [ -z "$(artifact)" ]; then \
		echo "❌ Please provide an artifact filename from the artifacts folder, e.g., make import artifact=chapter1.docx"; \
		exit 1; \
	fi
	@$(IMPORT) "$(artifact)"
	@echo ""
	@echo "📦 Next steps:"
	@echo "  • Review your ./artifacts folder and move imported content to:"
	@echo "    → ./chapters — to store chapters"
	@echo "    → ./appendix — to store appendices"
	@echo "    → ./assets   — to store images and other assets"
	@echo ""
	@echo "💡 Tip: Keeping one file per chapter or appendix is ideal for clarity and maintainability."
	@echo ""
	@echo "📝 Edit your Markdown files:"
	@echo "  • Adjust headings and subheadings as needed"
	@echo "  • Update to keep one file per chapter or appendix"
	@echo "  • Update image paths to use ./assets where applicable"
	@echo ""
	@echo "📚 Finally, update publish.txt to include the new chapters or appendices in the desired order"
	@echo ""

# Publish a specific output (PDF or EPUB) for a given target (default: book)
# Usage: make publish [target=book] [format=pdf|epub]
publish:
	@$(PUBLISH) $(target) $(format)

# Build all supported formats for the default target
all:
	@$(PUBLISH) book pdf
	@$(PUBLISH) book epub
	@$(PUBLISH) book docx

# Clean up build artifacts and unused Docker images
clean:
	@echo "🧹 Removing generated artifacts..."
	@rm -fv $(shell find ./artifacts -type f ! -name '.gitkeep' ! -name '.DS_Store')
	@echo ""

# Install sample content
sample:
	@if grep -Ev '^\s*#|^\s*$$' publish.txt | grep -q .; then \
		echo "❌ Cannot install sample content: publish.txt is not empty."; \
		echo "   Please clear it manually or move your content before running 'make sample'."; \
		exit 1; \
	fi
	@echo "📦 Installing Keystone sample content..."
	@$(DC) run --rm keystone ./.pandoc/export-sample.sh
	@cp -rv artifacts/sample/. ./
	@rm -rf artifacts/sample/
	@echo "✅ Sample content installed. You can now run 'make all' to build your first book."
	@echo ""

# Show help message
help:
	@echo ""
	@echo "Keystone Build Commands:"
	@echo "  make publish [target=book] [format=pdf|epub|docx]  Build a specific format (default: book.pdf)"
	@echo "  make import artifact=input-file.ext                Import a document (DOCX, ODT, RTF) from ./artifacts"
	@echo "  make all                                           Build all supported formats (PDF, EPUB, DOCX)"
	@echo "  make clean                                         Delete generated artifacts from ./artifacts"
	@echo "  make sample                                        Install sample content (chapters and appendix)"
	@echo "  make help                                          Show this message"
	@echo ""
