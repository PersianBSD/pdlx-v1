# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

#!/usr/bin/env bash
set -euo pipefail

here="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

echo "== pdt-installer tests =="

bash test_base_ok_dryrun.sh
bash test_base_missingdep.sh

bash test_chroot_badargs.sh
bash test_chroot_dryrun_ok.sh

bash test_fstab_ok_dryrun.sh
bash test_fstab_missingdep.sh

echo "== ALL TESTS PASSED =="
