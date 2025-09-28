# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

#!/usr/bin/env bash
set -euo pipefail
. "$(dirname "$0")/lib.sh"

tmp="$(mktemp -d)"
mkdir -p "$tmp"/{dev,proc,sys,etc}

code="$(run_capture_code "$BIN" --dry-run --chroot "$tmp" /bin/true)"
expect_code "$code" 0 "chroot(dry-run) OK"
pass "chroot(dry-run) OK"
