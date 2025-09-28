# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------
#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"/.. && pwd)"
BIN="$ROOT_DIR/pdt-installer"

pass() { printf "✓ %s\n" "$*"; }
fail() { printf "✗ %s\n" "$*" >&2; exit 1; }
skip() { printf "↷ SKIP: %s\n" "$*"; exit 0; }

have_cmd() { command -v "$1" >/dev/null 2>&1; }

run_capture_code() {
  # run_capture_code CMD... -> prints exit code to stdout; swallows output
  set +e
  "$@" >/dev/null 2>&1
  local code=$?
  set -e
  echo "$code"
}

expect_code() {
  local got="$1" exp="$2" name="$3"
  [ "$got" -eq "$exp" ] || fail "$name (expected $exp got $got)"
}

# Create a PATH that hides certain commands
hide_cmds_env() {
  # usage: eval "$(hide_cmds_env pacstrap genfstab)"
  local tmp
  tmp="$(mktemp -d)"
  # put a dummy busy PATH dir with nothing inside; ensures not found
  echo "export PATH='$tmp'"
}
