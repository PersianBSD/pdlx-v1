# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

# bash completion for pdt-installer (long subcommands only)
_pdt_installer()
{
  local cur prev words cword
  _init_completion || return

  local tops="--base --chroot --fstab --verbose -v --quiet -q --dry-run --log --version --help -h"
  local pacstrap_opts="-C -c -D -G -i -K -M -N -P -U -h"
  local chroot_opts="-N -u -r -h"
  local genfstab_opts="-L -U -t -p -h"

  local sub=""
  for w in "${words[@]}"; do
    case "$w" in
      --base)   sub="base";;
      --chroot) sub="chroot";;
      --fstab)  sub="fstab";;
    esac
  done

  if [[ -z "$sub" ]]; then
    COMPREPLY=( $(compgen -W "$tops" -- "$cur") )
  else
    case "$sub" in
      base)   COMPREPLY=( $(compgen -W "$pacstrap_opts" -- "$cur") ) ;;
      chroot) COMPREPLY=( $(compgen -W "$chroot_opts" -- "$cur") ) ;;
      fstab)  COMPREPLY=( $(compgen -W "$genfstab_opts" -- "$cur") ) ;;
    esac
  fi

  if [[ "$prev" == "-C" || "$prev" == "--log" || "$prev" == "-t" || "$prev" == "-u" ]]; then
    COMPREPLY=( $(compgen -o plusdirs -f -- "$cur") )
  fi
}
complete -F _pdt_installer pdt-installer
