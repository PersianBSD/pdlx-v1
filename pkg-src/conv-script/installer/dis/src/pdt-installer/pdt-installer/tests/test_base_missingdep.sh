# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

#!/usr/bin/env bash
set -euo pipefail
. "$(dirname "$0")/lib.sh"

eval "$(hide_cmds_env pacstrap)"
code="$(run_capture_code "$BIN" --base -U /mnt base)"
expect_code "$code" 20 "base missing dep -> exit 20"
pass "base missing dep"
