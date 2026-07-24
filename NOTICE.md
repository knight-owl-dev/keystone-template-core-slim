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
- Included in the Docker image (TeX Live installed via `install-tl` from a pinned tlnet snapshot, packages via `tlmgr`). Per-package licenses vary — see TeX Live Packages below.

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

### yq

- License: [MIT License](https://github.com/mikefarah/yq/blob/master/LICENSE)
- Source: [https://github.com/mikefarah/yq](https://github.com/mikefarah/yq)
- Included in the Docker image

## TeX Live Packages

Installed via `install-tl` and `tlmgr` from a pinned tlnet snapshot
(`TL_SNAPSHOT` in `.docker/Dockerfile`). Font packages are listed
separately under Fonts. Each license was confirmed per package with
`tlmgr info <pkg>` (the `cat-license` field).

### Base LaTeX / XeLaTeX packages

The general engine and pandoc-template closure, installed in the Docker `base`
stage. Each package's source is `https://ctan.org/pkg/<name>`.

- [LPPL](https://www.latex-project.org/lppl/): amsmath, babel, babel-basque,
  babel-czech, babel-danish, babel-dutch, babel-english, babel-finnish,
  babel-french, babel-german, babel-hungarian, babel-italian, babel-norsk,
  babel-polish, babel-portuges, babel-spanish, babel-swedish, bidi, bookmark,
  booktabs, caption, fancyvrb, float, fontspec, footnotehyper, geometry,
  graphics, hyperref, iftex, latex, microtype, multirow, parskip, setspace,
  soul, tools, unicode-math, upquote, xcolor, xurl
- [X11/MIT](https://spdx.org/licenses/X11.html): xetex
- [SIL Open Font License](https://openfontlicense.org/): amsfonts (AMS math
  symbol fonts)
- Free (permissive, redistribution allowed): framed, ulem

`lm` and `lm-math` are also installed here for the default and math fonts; they
are licensed under the GUST Font License and attributed under Fonts › Latin
Modern.

Hyphenation patterns (`hyphen-basque` through `hyphen-swedish`) ship via
[hyph-utf8](https://ctan.org/pkg/hyph-utf8). Each language file carries its own
license — MIT, LGPL, GPL, public domain, the Knuth license, or other free terms
— documented in the pattern files themselves.

### Keystone feature packages

Installed in the Docker `keystone-tex` stage for Keystone's own features. All
are licensed under the LaTeX Project Public License (LPPL).

### draftwatermark

- License: [LPPL 1.3c or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/draftwatermark](https://ctan.org/pkg/draftwatermark)
- Included in the Docker image

### endnotes

- License: [LPPL 1.2](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/endnotes](https://ctan.org/pkg/endnotes)
- Included in the Docker image

### fancyhdr

- License: [LPPL 1.3 or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/fancyhdr](https://ctan.org/pkg/fancyhdr)
- Included in the Docker image

### fvextra

- License: [LPPL 1.3a or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/fvextra](https://ctan.org/pkg/fvextra)
- Included in the Docker image

### hyperxmp

- License: [LPPL 1.3c or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/hyperxmp](https://ctan.org/pkg/hyperxmp)
- Included in the Docker image

### koma-script

- License: [LPPL 1.3c or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/koma-script](https://ctan.org/pkg/koma-script)
- Included in the Docker image

### lettrine

- License: [LPPL 1.3c or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/lettrine](https://ctan.org/pkg/lettrine)
- Included in the Docker image

### lineno

- License: [LPPL 1.3a or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/lineno](https://ctan.org/pkg/lineno)
- Included in the Docker image

### pdfcol

- License: [LPPL 1.3c or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/pdfcol](https://ctan.org/pkg/pdfcol)
- Included in the Docker image

### psnfss

- License: [LPPL](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/psnfss](https://ctan.org/pkg/psnfss)
- Provides `pifont.sty` (Dingbat symbols); included in the Docker image

### ragged2e

- License: [LPPL 1.3c or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/ragged2e](https://ctan.org/pkg/ragged2e)
- Included in the Docker image

### tcolorbox

- License: [LPPL 1.3c or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/tcolorbox](https://ctan.org/pkg/tcolorbox)
- Included in the Docker image

### tikzfill

- License: [LPPL 1.3c or later](https://www.latex-project.org/lppl/)
- Source: [https://ctan.org/pkg/tikzfill](https://ctan.org/pkg/tikzfill)
- Included in the Docker image

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

Latin Modern Roman and the Latin Modern Math font (latinmodern-math).

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

### Noto Sans Mono

- License: SIL Open Font License 1.1
- Source: [https://github.com/notofonts/latin-greek-cyrillic](https://github.com/notofonts/latin-greek-cyrillic)
- Included in the Docker image
- License file: [.licenses/Fonts.md](.licenses/Fonts.md)

### Source Code Pro

- License: SIL Open Font License 1.1
- Source: [https://github.com/adobe-fonts/source-code-pro](https://github.com/adobe-fonts/source-code-pro)
- Included in the Docker image
- License file: [.licenses/Fonts.md](.licenses/Fonts.md)

### Fourier Ornaments

Ornamental glyph font (FourierOrns) from the fourier package.

- License: LaTeX Project Public License 1.3c
- Source: [https://ctan.org/pkg/fourier](https://ctan.org/pkg/fourier)
- Included in the Docker image
- License file: [.licenses/Fonts.md](.licenses/Fonts.md)

### IM Fell Flowers

Floral printer's ornaments (FeFlow1, FeFlow2) from the imfellenglish package.

- License: SIL Open Font License 1.1
- Source: [https://ctan.org/pkg/imfellenglish](https://ctan.org/pkg/imfellenglish)
- Included in the Docker image
- License file: [.licenses/Fonts.md](.licenses/Fonts.md)

## Citation Styles (CSL)

The following Citation Style Language (CSL) styles are included in the Keystone
Docker image to format citations and bibliographies via Pandoc citeproc. Each is
an independent data file distributed alongside Keystone (mere aggregation under
GPL Section 2) and is redistributed unmodified.

### Chicago Manual of Style

Chicago Manual of Style 18th edition — author-date and notes-and-bibliography
variants, from the Citation Style Language project.

- License: [Creative Commons Attribution-ShareAlike 3.0](https://creativecommons.org/licenses/by-sa/3.0/)
- Source: [https://github.com/citation-style-language/styles](https://github.com/citation-style-language/styles)
- Included in the Docker image

---

This project is grateful for the incredible work of these communities and individuals. Their tools are the foundation on which Keystone is built.
