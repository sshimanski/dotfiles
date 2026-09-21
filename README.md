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

## System files

Root-owned, so they are kept here as copies and installed by hand.

- `tlp/98-local.conf` -> `/etc/tlp.d/98-local.conf` — AC-side power settings that
  differ from TLP's defaults. Install and apply:

  ```
  sudo install -m 644 tlp/98-local.conf /etc/tlp.d/98-local.conf && sudo tlp start
  ```

  `/etc/tlp.conf` itself stays at package defaults, so a TLP upgrade never asks
  about a modified conffile.

- `powercap/` — sustained CPU power limit (PL1), which TLP cannot set. Install
  once:

  ```
  sudo install -m 644 powercap/cpu-powercap.service powercap/cpu-powercap.path /etc/systemd/system/
  sudo systemctl daemon-reload
  sudo systemctl enable --now cpu-powercap.service cpu-powercap.path
  ```

  After that `powercap/powercap.conf` is edited without root: the path unit
  re-applies the limit on every write, and the service repeats it at boot and
  after resume.

  `thermald` must stay disabled (`systemctl disable --now thermald`): it rewrites
  the same RAPL constraint about 14 s after every write, measured, and silently
  undoes the limit. Nothing is lost by disabling it - thermal protection is in the
  silicon, and with the limit in place the package sits ~15 C below where thermald
  used to let it bounce off TjMax.

## Kept outside this repo

Restore these by hand; `scripts/link` reports the GTK4 ones.

- `~/.gtkrc-2.0` — GTK2 theme and font names, rewritten by lxappearance.
- `~/.config/gtk-4.0/{gtk.css,gtk-dark.css,assets}` — links into the installed
  GTK theme.
- `~/.config/JetBrains/*/idea64.vmoptions` — carries `-Dsun.java2d.uiScale`.
- `~/.themes`, `~/.icons` — GTK and icon themes.
