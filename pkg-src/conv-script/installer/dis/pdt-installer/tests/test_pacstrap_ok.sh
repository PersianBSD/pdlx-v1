# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

#!/usr/bin/env bash
set -euo pipefail
# Requires arch-install-scripts in PATH to truly run; we DRY-RUN here.

../pdt-installer --dry-run --pacstrap -U /mnt base >/dev/null
code=$?
[ "$code" -eq 0 ] || { echo "expected 0, got $code"; exit 1; }
echo "OK: pacstrap dry-run"
