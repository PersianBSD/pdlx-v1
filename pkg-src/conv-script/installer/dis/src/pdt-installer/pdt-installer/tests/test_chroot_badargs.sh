# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

#!/usr/bin/env bash
set -euo pipefail
. "$(dirname "$0")/lib.sh"

code="$(run_capture_code "$BIN" --chroot)"
expect_code "$code" 31 "chroot missing ROOT -> exit 31"
pass "chroot bad-args"
