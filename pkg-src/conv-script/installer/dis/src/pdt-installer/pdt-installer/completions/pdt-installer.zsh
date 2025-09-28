# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

#compdef pdt-installer
_arguments -C \
  '(-h --help)'{-h,--help}'[Show help]' \
  '(-v --verbose)'{-v,--verbose}'[Verbose]' \
  '(-q --quiet)'{-q,--quiet}'[Quiet]' \
  '--dry-run[Dry run]' \
  '--log+[Log file]:file:_files' \
  '--version[Show version]' \
  '--base[Act like pacstrap]' \
  '--chroot[Act like arch-chroot]' \
  '--fstab[Act like genfstab]' \
  '*::args:_pdt_args'

_pdt_args() {
  if (( words[(I)--base] )); then
    _arguments \
      '-C+[Pacman config]:file:_files' \
      '-c[Use host pacman cache]' \
      '-D[Do not use host keyring]' \
      '-G[Do not copy pacman.conf]' \
      '-i[Interactive]' \
      '-K[Init new keyring in target]' \
      '-M[Do not copy mirrorlist]' \
      '-N[Do not copy network config]' \
      '-P[Copy pacman config to target]' \
      '-U[Use pacman -U]' \
      '-h[Help]'
  elif (( words[(I)--chroot] )); then
    _arguments \
      '-N[Do not mount API filesystems]' \
      '-u+[User:Group]:user:_users' \
      '-r[Run as root preserving context]' \
      '-h[Help]'
  elif (( words[(I)--fstab] )); then
    _arguments \
      '-L[Use labels]' \
      '-U[Use UUIDs]' \
      '-t+[Tag filter]:tag:' \
      '-p[Show pseudo filesystems]' \
      '-h[Help]'
  else
    _files
  fi
}
