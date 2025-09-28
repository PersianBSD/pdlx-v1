# ------------------------------------------------------------------------------
# Project:   pdt-installer
# Author:    Ali Asadi <ali.asady@gmail.com>
# Team:      Persian Developer Team
# License:   GPL-3.0-or-later


PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
COMPDIR_BASH ?= $(PREFIX)/share/bash-completion/completions
COMPDIR_ZSH  ?= $(PREFIX)/share/zsh/site-functions
COMPDIR_FISH ?= $(PREFIX)/share/fish/vendor_completions.d

all: build

build:
	@echo "Nothing to build (script + manpage already provided)."

install:
	install -Dm755 pdt-installer "$(DESTDIR)$(BINDIR)/pdt-installer"
	install -Dm644 docs/pdt-installer.8 "$(DESTDIR)$(MANDIR)/man8/pdt-installer.8"
	install -Dm644 completions/pdt-installer.bash "$(DESTDIR)$(COMPDIR_BASH)/pdt-installer"
	install -Dm644 completions/pdt-installer.zsh  "$(DESTDIR)$(COMPDIR_ZSH)/_pdt-installer"
	install -Dm644 completions/pdt-installer.fish "$(DESTDIR)$(COMPDIR_FISH)/pdt-installer.fish"

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/pdt-installer"
	rm -f "$(DESTDIR)$(MANDIR)/man8/pdt-installer.8"
	rm -f "$(DESTDIR)$(COMPDIR_BASH)/pdt-installer"
	rm -f "$(DESTDIR)$(COMPDIR_ZSH)/_pdt-installer"
	rm -f "$(DESTDIR)$(COMPDIR_FISH)/pdt-installer.fish"

lint:
	shellcheck -x pdt-installer || true

test:
	cd tests && bash test_pacstrap_ok.sh && bash test_chroot_badargs.sh && bash test_fstab_missingdep.sh

.PHONY: all build install uninstall lint test
