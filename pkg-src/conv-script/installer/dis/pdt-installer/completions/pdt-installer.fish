# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later
# ------------------------------------------------------------------------------

# fish completion for pdt-installer (long subcommands only)
complete -c pdt-installer -s v -l verbose -d "Verbose"
complete -c pdt-installer -s q -l quiet -d "Quiet"
complete -c pdt-installer -l dry-run -d "Dry run"
complete -c pdt-installer -l log -r -d "Log file"
complete -c pdt-installer -l version -d "Version"
complete -c pdt-installer -s h -l help -d "Help"

complete -c pdt-installer -l base   -d "pacstrap mode"
complete -c pdt-installer -l chroot -d "arch-chroot mode"
complete -c pdt-installer -l fstab  -d "genfstab mode"

for o in C c D G i K M N P U h
    complete -c pdt-installer -n '__fish_seen_argument --base' -s $o -d "pacstrap option"
end
complete -c pdt-installer -n '__fish_seen_argument --base; and __fish_prev_arg_in -C' -a "(__fish_complete_directories)"

for o in N r h
    complete -c pdt-installer -n '__fish_seen_argument --chroot' -s $o -d "chroot option"
end
complete -c pdt-installer -n '__fish_seen_argument --chroot; and __fish_prev_arg_in -u' -s u -x -a "(__fish_complete_users)"

for o in L U p h
    complete -c pdt-installer -n '__fish_seen_argument --fstab' -s $o -d "genfstab option"
end
complete -c pdt-installer -n '__fish_seen_argument --fstab; and __fish_prev_arg_in -t' -s t -x
