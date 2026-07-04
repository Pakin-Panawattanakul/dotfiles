---
name: void-pkg-diff
description: Compare packages referenced in files/Scripts/install/void-install.sh against what xbps currently has installed on this machine. Use when the user asks to check for missing packages, drift between void-install.sh and the system, or wants to audit manually-installed vs scripted packages on Void Linux.
---

Run the package diff script and report its output to the user:

```sh
bash files/Scripts/install/void-package-diff.sh
```

This script (in `files/Scripts/install/void-package-diff.sh`) parses `void-install.sh` directly — no separate package list to keep in sync — and reports four sections:

1. **Required packages referenced in void-install.sh but NOT installed at all** — real gaps, should basically always be empty.
2. **Required packages installed only as a dependency (not manual)** — present on the system but not flagged manual by xbps, usually harmless but flags candidates for `xbps-pkgdb -m manual <pkg>` if the user wants them protected from orphan cleanup.
3. **Optional packages (wireless/nvidia/intel) NOT installed at all** — packages inside `wireless_setup`, `install_nvidia`, `install_intel`, which are gated behind `ask_install` prompts in the script. Missing entries here are expected/normal if the user opted out of that prompt, not necessarily a problem.
4. **Manually installed but NOT referenced anywhere in void-install.sh** — packages the user installed by hand outside the script. Base-install/bootloader packages (`base-system`, `grub-i386-efi`, `grub-x86_64-efi`, `linux`) are already excluded from this list since they come from the void-installer itself, not this script.

When reporting results, summarize each section briefly rather than dumping raw output uninterpreted — call out anything that looks like real drift (section 1, or new unexpected entries in section 4) versus expected noise (sections 2 and 3).

After reporting, always give the user the fix-up commands directly in chat as copy-pasteable one-liners — do NOT write them to script files, and never execute `sudo` commands directly:

1. **Section 1 (missing required packages)** — `sudo xbps-install -S <pkg> <pkg> ...` for everything missing.
2. **Section 2 (installed only as dependency)** — `sudo xbps-pkgdb -m manual <pkg> <pkg> ...` to mark them manual.
3. **Section 3 (optional packages not installed)** — leave as-is, no command needed.
4. **Section 4 (manual but unreferenced)** — `sudo xbps-remove -Rf <pkg> <pkg> ...` to remove them.

Skip a section's command if that section is empty. Flag if any package in section 4 looks load-bearing (e.g. `cryptsetup`, `lvm2` for disk encryption/LVM) before suggesting removal.
