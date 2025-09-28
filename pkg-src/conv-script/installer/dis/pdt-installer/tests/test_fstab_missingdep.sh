# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

#!/usr/bin/env bash
set -euo pipefail
. "$(dirname "$0")/lib.sh"

eval "$(hide_cmds_env genfstab)"
code="$(run_capture_code "$BIN" --fstab -U /mnt)"
expect_code "$code" 40 "fstab missing dep -> exit 40"
pass "fstab missing dep"
