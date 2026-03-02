# Custom Fonts

Bring your own fonts to Keystone by placing `.otf` files in this directory and
registering them in `fonts-registry.yaml`. Registered fonts work everywhere
built-in fonts do — as the document font, in `.font` div/span overrides, and
in shortcuts.

## Quick Start

1. **Place font files** — copy `.otf` files into this `fonts/` directory
2. **Register** — add an entry to `fonts-registry.yaml` (see examples below)
3. **Use** — reference the font key in `pandoc.yaml` or `.font` divs

## Registry Format

Each entry maps a key (your chosen name) to font metadata:

```yaml
my-serif:
  main:
    file: MySerif-Regular.otf
    bold: MySerif-Bold.otf
    italic: MySerif-Italic.otf
    bold_italic: MySerif-BoldItalic.otf
  css: '"My Serif", "Georgia", serif'
```

**Required:** `main.file` and `css`. Everything else is optional.

### The `css` field

The `css` value is a CSS `font-family` stack. The first quoted name becomes
the `@font-face` family name in EPUB; subsequent values are fallbacks for
e-readers that can't load embedded fonts.

```yaml
# Serif with fallbacks
css: '"My Serif", "Georgia", serif'

# Sans-serif with fallbacks
css: '"My Sans", "Helvetica Neue", sans-serif'

# Monospace with fallbacks
css: '"My Mono", "Courier New", monospace'
```

## Common Scenarios

### Serif with all variants

```yaml
my-serif:
  main:
    file: MySerif-Regular.otf
    bold: MySerif-Bold.otf
    italic: MySerif-Italic.otf
    bold_italic: MySerif-BoldItalic.otf
  css: '"My Serif", "Georgia", serif'
```

### Single-weight display font

```yaml
my-display:
  main:
    file: MyDisplay-Regular.otf
  css: '"My Display", "Georgia", serif'
```

### Serif + sans pair with companion

```yaml
my-serif:
  main:
    file: MySerif-Regular.otf
    bold: MySerif-Bold.otf
    italic: MySerif-Italic.otf
    bold_italic: MySerif-BoldItalic.otf
  css: '"My Serif", "Georgia", serif'
  sans: my-sans

my-sans:
  main:
    file: MySans-Regular.otf
    bold: MySans-Bold.otf
  css: '"My Sans", "Helvetica Neue", sans-serif'
```

When `my-serif` is set as the document font, Keystone also sets the
sans-serif font to `my-sans` automatically.

## Referencing User Fonts

### Document font

Set `fontfamily` in `pandoc.yaml` to the registry key:

```yaml
fontfamily: my-serif
```

### Inline overrides

Use `.font` divs and spans with `family=`:

```markdown
::: {.font family="my-serif"}
This paragraph renders in My Serif.
:::

A word in [My Serif]{.font family="my-serif"} inline.
```

Or define a shortcut in `shortcuts.yaml`:

```yaml
my-serif-text:
  class: font
  family: my-serif
```

## Validation

Keystone validates font entries at build time:

- **Missing files** — if a declared `.otf` file doesn't exist in `fonts/`,
  the entry is skipped with a warning. Check the build output for
  `WARN: user font` messages.
- **Key collisions** — if a user font key matches a built-in font name, the
  built-in wins and a warning is emitted. Choose a different key.
- **Missing required fields** — entries without `main.file` or `css` are
  skipped with a warning.

## File Requirements

- Font files must be OpenType (`.otf`) format
- All font files go flat in this `fonts/` directory (no subdirectories)
