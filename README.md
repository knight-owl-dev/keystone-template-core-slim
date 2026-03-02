# 🧱 Keystone

> Simple things should be simple, and difficult things should be possible.

Keystone is devops for publishing — a minimalist template that puts you in full control of your content pipeline, from Markdown to professional-quality output, with no black boxes.

It gives you a reproducible build system, clean separation of layout and content, and a dev-friendly workflow with just enough automation to stay out of your way.

Built with [Make](https://www.gnu.org/software/make/), [Markdown](https://www.markdownguide.org/getting-started/), [Pandoc](https://pandoc.org/), [LaTeX](https://www.latex-project.org/), and [Docker](https://www.docker.com/).

## Features

- ✍️ Write in plain [Markdown](https://www.markdownguide.org/getting-started/)
- 🚜 Build clean, timestamped artifacts via [`make`](https://www.gnu.org/software/make/)
- 📂 Configure metadata via [pandoc.yaml](pandoc.yaml) — control title, author, layout, keywords, and PDF formatting
- ⚖️ Powered by [Pandoc](https://pandoc.org/), [LaTeX](https://www.latex-project.org/), and [Docker](https://www.docker.com/)
- ⛏️ Keeps guts out of your way - relies on a prebuilt [Keystone](https://github.com/orgs/knight-owl-dev/packages/container/keystone) Docker image
- ⌨️ Editor-agnostic: works from any terminal

**Why Pandoc?** It’s flexible, scriptable, and supports features like table of contents generation, custom styling, page breaks, heading levels, bibliography, footnotes, and cross-referencing — everything you need to produce a structured, professional-quality document.

### Markdown Formatting Capabilities

Keystone supports advanced formatting through [Pandoc's fenced div syntax](https://pandoc.org/MANUAL.html#extension-fenced_divs), using the form `::: div-name` and `:::`.

This lets you apply custom styling or behavior by wrapping sections of content in named blocks — like `::: dialog` for character conversations.

For example, you can create a dialog block like this:

```markdown
::: dialog

- Who’s there?
- Just the wind.
:::
```

> 💡 No special syntax is needed for prose-style dialog; just write your dialog using standard Markdown. The output will format it as prose.

For more examples, see the [keystone-hello-world](https://github.com/knight-owl-dev/keystone-hello-world) project.

### Advanced LaTeX Support

Keystone supports inline LaTeX inserts when building PDF output. This gives you full access to custom tables, equations, symbols, and layout commands — all embedded directly in your Markdown.

To include raw LaTeX in your document, wrap it in a `::: latex-only` block. This ensures it’s rendered only in LaTeX/PDF output, and skipped in other formats like DOCX or EPUB.

For example, here’s a LaTeX table using `\tick` symbols:

```latex
::: latex-only
\begin{center}
\begin{tabular}{|c|c|}
  \hline
  \textbf{Feature} & \textbf{Supported?} \\
  \hline
  Markdown         & \tick \\
  LaTeX Inserts    & \tick \\
  Lua Filters      & \tick \\
  Dockerized Builds & \tick \\
  \hline
\end{tabular}
\end{center}
:::
```

## Quick Start

**1. Use this repo as a template:** Click the “Use this template” button on GitHub to create your own book project (e.g., `my-book`), then:

```shell
git clone git@github.com:yourname/my-book.git
cd my-book
```

**2. Configure your project:** `project.conf` sets the project name and Docker naming. `pandoc.yaml` holds all document metadata — title, author, description, layout, and cover image. Both files are version-controlled and used at build time.

```shell
nano project.conf
nano pandoc.yaml
```

**3. Add content:** Write your book in [Markdown](https://www.markdownguide.org/getting-started/). Keystone uses a simple folder structure to keep things organized:

```text
manuscript/    # Your content — chapters, appendices, etc.
assets/        # Images, cover.png, etc.
```

The [publish.txt](publish.txt) file defines the exact order of files to be included in the output. Edit it to rearrange chapters or exclude drafts without renaming source files.

For example, create and add these files to [publish.txt](publish.txt):

```text
manuscript/introduction.md
manuscript/chapter-1.md
manuscript/appendix-a.md
```

>💡 Pandoc numbers all top-level sections automatically.

Because of this, avoid including chapter numbers in your Markdown titles — they’re applied during export. This keeps the source files clean and makes renumbering painless.

To exclude specific headings (e.g. in a preface or appendix), use the `{.unnumbered}` attribute on each header in the file:

```markdown
# Preface {.unnumbered}
## Introduction {.unnumbered}
```

**4. Build your book:**

```shell
make all
```

Outputs will appear in the [artifacts/](/artifacts/) folder. For example, if you set `KEYSTONE_PROJECT=hello-world` in [project.conf](project.conf), the output will be:

```text
artifacts/
├── hello-world-book-20250405.pdf
├── hello-world-book-20250405.epub
└── ...

> Other targets are available: `target: report` for chapter-structured
> documents with single-sided layout (theses, manuals), or
> `target: article` for shorter-form works with section headings
> (essays, papers). Both require `abstract` instead of `description`.
```

## Importing Existing Documents

Keystone supports importing existing documents (such as .docx, .odt, or .html) and converting them to Markdown using Pandoc.

This allows you to bring in drafts or outlines from Word or other editors and start working with them in your versioned Markdown workflow.

### How to Use

Place your document in the artifacts/ folder, for example:

```text
artifacts/my-draft.docx
```

Run the import command:

```shell
make import artifact=my-draft.docx
```

The converted Markdown will be saved as:

```text
artifacts/my-draft-imported.md
```

### Next Steps After Import

- Move the converted Markdown file to [./manuscript](/manuscript/)
- Move media assets to [./assets](/assets/) if needed
- Adjust heading levels and image paths in the Markdown file
- Update [publish.txt](publish.txt) to include the new file in your book structure

> **Tip:** Structure your content with **one file per chapter or section**. While it’s technically possible to keep everything in a single file, doing so can make your project harder to manage and maintain over time.

## Project Configuration

Configuration is split across two files:

- **`project.conf`** — project name and Docker naming (operational plumbing)
- **`pandoc.yaml`** — all document metadata: title, author, description, keywords,
  PDF layout (paper size, margins, font), and EPUB options (cover image)

Pandoc reads layout and EPUB settings directly from `pandoc.yaml` — no
environment variables needed.

> For examples and advanced options, see the commented blocks in both files.

### Keystone Template Variants

This is the slim variant of the core Keystone template — the editor-agnostic version that uses a prebuilt Docker image. Choose this variant if you want faster builds, smaller images, and don't need to modify publishing internals.

- 🛠️ No IDE-specific tooling
- 📄 Works with any text editor
- 🔧 Built for use directly from the terminal using make
- Encapsulates all dependencies in a Docker image for faster builds and better space management

Looking for a more integrated experience? Consider using the [keystone-template-core](https://github.com/knight-owl-dev/keystone-template-core) variant for more control and flexibility, or if you need to customize Pandoc.

### Requirements

- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/)
- [GNU Make](https://www.gnu.org/software/make/)
- Learn the [Markdown](https://www.markdownguide.org/basic-syntax/) basic syntax
- Use any editor or IDE of your choice

### Cross-Platform Compatibility & Line Endings

If you're using Windows, run this project inside [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) for full compatibility. Keystone requires `LF` (Unix-style) line endings — this is enforced by [.editorconfig](/.editorconfig). Avoid `CRLF` endings to prevent formatting and build issues.

### Using the GNU Make Utility

This project has the [Makefile](Makefile) to simplify the workflow and assumes [Docker Desktop](https://www.docker.com/products/docker-desktop/) is installed.

> 💡 On Windows, open this project inside [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) and run `make` from a WSL terminal for the best results. This ensures consistent paths, permissions, and line endings. See [this](https://learn.microsoft.com/en-us/windows/wsl/filesystems#file-storage-and-performance-across-file-systems) article for more info.

You can run these commands from your terminal or integrate them into your flow:

| Target    | Description                                                                      |
|-----------|----------------------------------------------------------------------------------|
| `import`  | Imports a document (DOCX, ODT, RTF) from the artifacts folder                    |
| `publish` | Builds a specific format using [publish.sh](publish.sh)                          |
| `all`     | Builds PDF, EPUB and DOCX formats                                                |
| `clean`   | Prunes images and deletes generated PDFs/EPUBs from [artifacts](/artifacts/)     |
| `verify`  | Verifies the Docker image signature using cosign                                 |
| `help`    | Displays a list of available `Make` targets and usage examples                   |

Example:

```shell
make publish
make publish format=epub
make all
make clean
make help
```

### Project structure

```text
.                       # Project root
├── .docker/            # Docker config
│   └── docker-compose.yaml
├── .keystone/          # Keystone metadata
│   └── sync.json       # Sync metadata
├── .licenses/          # License documents (Keystone, Pandoc)
├── artifacts/          # Output folder for built PDFs and EPUBs
├── assets/             # Images and cover art
├── manuscript/         # All content — chapters, appendices, etc.
├── fonts/              # Custom font files and registry
│   └── fonts-registry.yaml
├── .dockerignore       # Docker ignore file
├── .editorconfig       # Editor defaults
├── project.conf        # Project configuration
├── .gitattributes      # Git attributes
├── .gitignore          # Git ignore file
├── Makefile            # Build commands
├── NOTICE.md           # Project notices and third-party tool acknowledgments
├── pandoc.yaml         # Pandoc metadata (title, author, etc.)
├── README.md           # This file
└── publish.txt         # List of content files to include in order
```

Only `manuscript/`, `assets/`, and `fonts/` are recognized by the
publishing pipeline. You're free to create additional folders (e.g.
`drafts/`, `research/`, `notes/`) to organize your project however
you like — they won't affect the build.

### Built-in fonts

Keystone ships with these fonts — use them via `fontfamily:` in
`pandoc.yaml` or `family=` in `.font` divs. All TeX Live fonts embed
in both PDF and EPUB with full bold/italic support.

| Key | Font | Category | Preview |
| --- | --- | --- | --- |
| `libertine` | Linux Libertine | Serif | [CTAN][libertine-preview] |
| `biolinum` | Linux Biolinum | Sans-serif | [CTAN][libertine-preview] |
| `eb-garamond` | EB Garamond | Serif | [Google Fonts][ebgaramond-preview] |
| `latin-modern` | Latin Modern Roman | Serif | [GUST][lm-preview] |
| `tex-gyre-adventor` | TeX Gyre Adventor (Avant Garde) | Sans-serif | [GUST][texgyre-preview] |
| `tex-gyre-bonum` | TeX Gyre Bonum (Bookman) | Serif | [GUST][texgyre-preview] |
| `tex-gyre-cursor` | TeX Gyre Cursor (Courier) | Monospace | [GUST][texgyre-preview] |
| `tex-gyre-heros` | TeX Gyre Heros (Helvetica) | Sans-serif | [GUST][texgyre-preview] |
| `tex-gyre-pagella` | TeX Gyre Pagella (Palatino) | Serif | [GUST][texgyre-preview] |
| `tex-gyre-schola` | TeX Gyre Schola (Century Schoolbook) | Serif | [GUST][texgyre-preview] |
| `tex-gyre-termes` | TeX Gyre Termes (Times) | Serif | [GUST][texgyre-preview] |
| `dejavu-serif` | DejaVu Serif | Serif | [DejaVu][dejavu-preview] |
| `dejavu-sans` | DejaVu Sans | Sans-serif | [DejaVu][dejavu-preview] |
| `dejavu-mono` | DejaVu Sans Mono | Monospace | [DejaVu][dejavu-preview] |

> DejaVu fonts are system fonts — they work in PDF and use CSS fallback
> in EPUB but are not embedded as files in the EPUB archive.

Need a font that isn't listed? Place your `.otf` files in `fonts/` and
register them in [`fonts/fonts-registry.yaml`](fonts/fonts-registry.yaml).
See [`fonts/README.md`](fonts/README.md) for the complete setup guide.

[libertine-preview]: https://ctan.org/pkg/libertine
[ebgaramond-preview]: https://fonts.google.com/specimen/EB+Garamond
[lm-preview]: https://www.gust.org.pl/projects/e-foundry/latin-modern
[texgyre-preview]: https://www.gust.org.pl/projects/e-foundry/tex-gyre
[dejavu-preview]: https://dejavu-fonts.github.io/

## Image Integrity

The prebuilt Keystone Docker image is scanned for vulnerabilities before
every release, signed with [Sigstore](https://www.sigstore.dev/) cosign,
and ships with an SBOM (software bill of materials) attestation.

To verify the image signature:

```shell
make verify
```

To inspect the SBOM:

```shell
docker buildx imagetools inspect ghcr.io/knight-owl-dev/keystone:latest \
  --format '{{ json .SBOM }}'
```

No action is required on your part — `docker pull` works as before. These
tools are available if you need to audit the image for compliance or security
review purposes.

## A Note of Gratitude

Keystone stands on the shoulders of giants.

This project would not be possible without the incredible tools and communities that power its every build:

- [Pandoc](https://pandoc.org/) — the universal document converter
- [LaTeX](https://www.latex-project.org/) — for professional-quality typesetting
- [Docker](https://www.docker.com/) — containerized reproducibility made simple
- [GNU Make](https://www.gnu.org/software/make/) — declarative builds that just work
- [Lua](https://www.lua.org/) — a lightweight, expressive scripting language used to extend Pandoc
- [Markdown](https://www.markdownguide.org/) — the plain-text format that changed writing forever

Each one of these projects represents **years of collective wisdom**, **generosity**, and **craft** — made available freely, **for all**.

To their maintainers and contributors: **thank you**. Keystone is a bridge, but you laid the foundation.

## License

The Keystone template is released under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).

You are free to:

- Share and adapt this template for personal and non-commercial use
- Modify it to suit your book projects

However:

- Commercial use (including hosted services or SaaS platforms) is not permitted without express written permission
- Derivative works must be shared under the same license terms

See [.licenses/Keystone.md](.licenses/Keystone.md) for full details.

> ⚖️ Keystone builds upon Pandoc, which is licensed under the GNU General Public License (GPL).  
> For details, see [.licenses/Pandoc.md](.licenses/Pandoc.md).

## Attribution

Project Keystone is developed and maintained by [Knight Owl LLC](https://github.com/knight-owl-dev).
If you use this template or build upon it, a link back to this repository is appreciated.
Please also retain license and attribution notices in derivative works to help others trace the origin of the system.

## Start writing

Keystone is the foundation. What you build with it is entirely yours.

Ready to write your first book like a dev? Let's go.
