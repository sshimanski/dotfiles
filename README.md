Dotfiles repo

## External artifacts

Not tracked here, fetched once per machine.

- `~/.local/share/jol/jol-cli.jar` — enables `:JdtJol` in nvim (`nvim/ftplugin/java.lua`).
  Skipped silently when absent.

  ```
  mkdir -p ~/.local/share/jol && curl -sSLo ~/.local/share/jol/jol-cli.jar \
    https://repo1.maven.org/maven2/org/openjdk/jol/jol-cli/0.17/jol-cli-0.17-full.jar
  ```

## Restoring on a new machine

```
scripts/link            # report which $HOME symlinks are missing or wrong
scripts/link --apply    # create them
```

Assumes packages, fonts and themes are already installed — it only re-creates
the links that point into this repo, and never touches a real file.

## Checks

- `scripts/dpi-audit` — every client must agree on the UI scale derived from
  `Xft.dpi`. Run after a major IDE or toolkit upgrade; exits non-zero on drift.

## Kept outside this repo

Restore these by hand; `scripts/link` reports the GTK4 ones.

- `~/.gtkrc-2.0` — GTK2 theme and font names, rewritten by lxappearance.
- `~/.config/gtk-4.0/{gtk.css,gtk-dark.css,assets}` — links into the installed
  GTK theme.
- `~/.config/JetBrains/*/idea64.vmoptions` — carries `-Dsun.java2d.uiScale`.
- `~/.themes`, `~/.icons` — GTK and icon themes.
