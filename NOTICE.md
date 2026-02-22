# NOTICE

This project makes use of the following third-party tools and formats, which are not bundled with the template but are essential to its operation. Each is licensed separately and remains the property of its respective maintainers.

## Primary Tools and Dependencies

### Pandoc

- License: [GNU General Public License v2 or later](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
- Source: [https://pandoc.org/](https://pandoc.org/)
- Included in the Docker image
- License file: [.licenses/Pandoc.md](.licenses/Pandoc.md)

### LaTeX / TeX Live

- License: [LaTeX Project Public License (LPPL)](https://www.latex-project.org/lppl/)
- Source: [https://www.latex-project.org/](https://www.latex-project.org/)
- Used via the `pandoc/latex` Docker image
- Not redistributed by this project

### GNU Make

- License: [GNU General Public License v3 or later](https://www.gnu.org/licenses/gpl-3.0.html)
- Source: [https://www.gnu.org/software/make/](https://www.gnu.org/software/make/)
- Used as part of the build system (not redistributed)

### Lua

- License: [MIT License](https://www.lua.org/license.html)
- Source: [https://www.lua.org/](https://www.lua.org/)
- Used for optional Pandoc filters
- No Lua binaries are included in this project

### Docker

- License: [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- Source: [https://www.docker.com/](https://www.docker.com/)
- Used to run Pandoc/LaTeX in an isolated container
- This project does not bundle or distribute Docker itself

## Fonts

The following font families are included in the Keystone Docker image. Each is
an independent work distributed alongside Keystone (mere aggregation under
GPL Section 2). All permit redistribution and EPUB embedding.

### Linux Libertine / Linux Biolinum

- License: GPL-2.0-or-later with Font Exception OR OFL-1.1 (dual-licensed)
- Source: [https://libertine-fonts.org/](https://libertine-fonts.org/)
- Included in the Docker image
- License file: [.licenses/Fonts.md](.licenses/Fonts.md)

### DejaVu

- License: Bitstream Vera License
- Source: [https://dejavu-fonts.github.io/](https://dejavu-fonts.github.io/)
- Included in the Docker image
- License file: [.licenses/Fonts.md](.licenses/Fonts.md)

### Latin Modern

- License: GUST Font License (LPPL-1.3c)
- Source: [https://www.gust.org.pl/projects/e-foundry/latin-modern](https://www.gust.org.pl/projects/e-foundry/latin-modern)
- Included in the Docker image
- License file: [.licenses/Fonts.md](.licenses/Fonts.md)

### TeX Gyre Family

Pagella, Termes, Heros, Schola, Bonum, Adventor, Cursor.

- License: GUST Font License (LPPL-1.3c)
- Source: [https://www.gust.org.pl/projects/e-foundry/tex-gyre](https://www.gust.org.pl/projects/e-foundry/tex-gyre)
- Included in the Docker image
- License file: [.licenses/Fonts.md](.licenses/Fonts.md)

### EB Garamond

- License: SIL Open Font License 1.1
- Source: [https://github.com/georgd/EB-Garamond](https://github.com/georgd/EB-Garamond)
- Included in the Docker image
- License file: [.licenses/Fonts.md](.licenses/Fonts.md)

---

This project is grateful for the incredible work of these communities and individuals. Their tools are the foundation on which Keystone is built.
