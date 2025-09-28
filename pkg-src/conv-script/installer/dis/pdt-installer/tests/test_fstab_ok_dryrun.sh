# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

#!/usr/bin/env bash
set -euo pipefail
. "$(dirname "$0")/lib.sh"

have_cmd genfstab || skip "genfstab not installed"
code="$(run_capture_code "$BIN" --dry-run --fstab -U /mnt)"
expect_code "$code" 0 "fstab(dry-run) OK"
pass "fstab(dry-run) OK"
