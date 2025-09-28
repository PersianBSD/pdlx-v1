# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

#!/usr/bin/env bash
set -euo pipefail
. "$(dirname "$0")/lib.sh"

have_cmd pacstrap || skip "pacstrap not installed"
code="$(run_capture_code "$BIN" --dry-run --base -U /mnt base)"
expect_code "$code" 0 "base(dry-run) OK"
pass "base(dry-run) OK"
