#!/usr/bin/env bash
# pdt-installer — unify pacstrap, arch-chroot, genfstab under one CLI
# POSIX-friendly style, but Bash required (4.1+)
# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

set -euo pipefail

VERSION="0.1.1"
PROG="pdt-installer"
LOG_FILE=""
VERBOSE=0
QUIET=0
DRYRUN=0

err() { printf "%s: %s\n" "$PROG" "$*" >&2; }
die() { err "$1"; exit "${2:-2}"; }
log() { [ -n "$LOG_FILE" ] && printf "%s\n" "$*" >>"$LOG_FILE" || :; }
vmsg() { [ "$VERBOSE" -eq 1 ] && printf "%s\n" "$*"; }
qwrap() { [ "$QUIET" -eq 1 ] && "$@" >/dev/null 2>&1 || "$@"; }
need_cmd() { command -v "$1" >/dev/null 2>&1 || return 1; }

check_deps() {
  local missing=()
  for c in install printf awk mount umount env sed grep cut tr getopts; do
    command -v "$c" >/dev/null 2>&1 || missing+=("$c")
  done
  if [ "${#missing[@]}" -gt 0 ]; then
    err "Missing required tools: ${missing* }"
    exit 10
  fi
}

usage() {
  cat <<'USAGE'
Usage:
  pdt-installer [Global Options] [--base | --chroot | --fstab] [subcmd options] [args...]

Global Options:
  -v, --verbose             Increase verbosity
  -q, --quiet               Silence stdout where sensible
      --dry-run             Show actions without executing
      --log <file>          Append logs to file
      --version             Show version and exit
  -h, --help                Show this help

Top-level subcommands (NO short forms):
  --base                    Act like pacstrap(8)
  --chroot                  Act like arch-chroot(8)
  --fstab                   Act like genfstab(8)

--base (pacstrap) options (passthrough 1:1):
  -C <file>  -c  -D  -G  -i  -K  -M  -N  -P  -U  -h

--chroot options:
  -N  -u <user[:group]>  -r  -h

--fstab (genfstab) options:
  -L  -U  -t <TAG>  -p  -h

Examples:
  pdt-installer --base  -U /mnt base linux
  pdt-installer --fstab -U /mnt >> /mnt/etc/fstab
  pdt-installer --chroot /mnt
  pdt-installer --base -c -U --chroot /mnt base   # pipeline: first subcmd wins (see notes)
USAGE
}

SUBCMD=""
SUBARGV=()

parse_global_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -v|--verbose) VERBOSE=1 ;;
      -q|--quiet) QUIET=1 ;;
      --dry-run) DRYRUN=1 ;;
      --log) [ $# -ge 2 ] || die "missing value for --log" 2; LOG_FILE="$2"; shift ;;
      --version) printf "%s %s\n" "$PROG" "$VERSION"; exit 0 ;;
      -h|--help) usage; exit 0 ;;
      --base|--chroot|--fstab)
        # اولین زیردستور = حالت انتخاب‌شده؛ از این لحظه باقی آرگومان‌ها فقط به همین زیردستور پاس می‌شوند
        [ -z "$SUBCMD" ] && SUBCMD="${1#--}" || :
        ;;
      --) shift; break ;;
      *) SUBARGV+=("$1") ;;
    esac
    shift
  done
  while [ $# -gt 0 ]; do SUBARGV+=("$1"); shift; done
}

cmd_base() {
  need_cmd pacstrap || die "pacstrap not found; install arch-install-scripts" 20
  local cmd=(pacstrap "${SUBARGV[@]}")
  vmsg "[base→pacstrap] ${cmd[*]}"; log "[base] ${cmd[*]}"
  if [ "$DRYRUN" -eq 1 ]; then printf "[DRY-RUN] %s\n" "${cmd[*]}"; return 0; fi
  "${cmd[@]}" || exit 21
}

cmd_chroot() {
  # parse minimal chroot options to extract ROOT and COMMAND...
  local opts=() root="" rest=()
  local i=0
  while [ $i -lt ${#SUBARGV[@]} ]; do
    case "${SUBARGV[$i]}" in
      -h) usage; exit 0 ;;
      -N|-r) opts+=("${SUBARGV[$i]}") ;;
      -u) opts+=("-u"); i=$((i+1)); [ $i -lt ${#SUBARGV[@]} ] || die "arch-chroot: -u requires an argument" 32; opts+=("${SUBARGV[$i]}") ;;
      --) rest+=("${SUBARGV[@]:$((i+1))}"); break ;;
      -*) opts+=("${SUBARGV[$i]}") ;;
      *)  if [ -z "$root" ]; then root="${SUBARGV[$i]}"; else rest+=("${SUBARGV[$i]}"); fi ;;
    esac
    i=$((i+1))
  done
  [ -n "$root" ] || die "arch-chroot: missing ROOT" 31
  [ -d "$root" ] || die "arch-chroot: ROOT is not a directory: $root" 31

  need_cmd mount || die "mount not found" 10
  need_cmd umount || die "umount not found" 10

  bind_mount() {
    local src="$1" dst="$2"
    [ -d "$dst" ] || mkdir -p "$dst"
    qwrap mount --rbind "$src" "$dst"
    qwrap mount --make-rslave "$dst" 2>/dev/null || :
  }

  cleanup() {
    for m in dev/pts dev sys proc; do
      if mountpoint -q "$root/$m"; then umount -R "$root/$m" 2>/dev/null || true; fi
    done
  }
  trap cleanup EXIT INT TERM

  vmsg "[chroot] preparing mounts under $root"
  if [ "$DRYRUN" -ne 1 ]; then
    bind_mount /dev  "$root/dev"
    bind_mount /proc "$root/proc"
    bind_mount /sys  "$root/sys"
    if [ -e /etc/resolv.conf ]; then
      [ -d "$root/etc" ] || mkdir -p "$root/etc"
      [ -e "$root/etc/resolv.conf" ] || cp -L /etc/resolv.conf "$root/etc/resolv.conf"
    fi
  fi

  local cmd=(chroot "$root")
  [ "${#rest[@]}" -gt 0 ] || rest=(/bin/bash)
  cmd+=("${rest[@]}")
  vmsg "[chroot] ${cmd[*]}"; log "[chroot] ${cmd[*]}"
  if [ "$DRYRUN" -eq 1 ]; then printf "[DRY-RUN] %s\n" "${cmd[*]}"; return 0; fi
  "${cmd[@]}" || exit 33
}

cmd_fstab() {
  need_cmd genfstab || die "genfstab not found; install arch-install-scripts" 40
  local cmd=(genfstab "${SUBARGV[@]}")
  vmsg "[fstab→genfstab] ${cmd[*]}"; log "[fstab] ${cmd[*]}"
  if [ "$DRYRUN" -eq 1 ]; then printf "[DRY-RUN] %s\n" "${cmd[*]}"; return 0; fi
  "${cmd[@]}" || exit 41
}

main() {
  check_deps
  parse_global_args "$@"
  [ -n "$SUBCMD" ] || { usage; exit 2; }

  case "$SUBCMD" in
    base)   cmd_base ;;
    chroot) cmd_chroot ;;
    fstab)  cmd_fstab ;;
    *) die "unknown subcommand: --$SUBCMD" 2 ;;
  esac
}

main "$@"
