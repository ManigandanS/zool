# This requires GNU Make. 

ifeq (${prefix}, ) 	# If no prefix set by user, use /usr/local/*/
  prefix=/usr/local
endif

ifeq (${bindir}, ) 	# Allow `bindir=~/bin make install` to force directory
  SPACEPATH=$(subst :, ,${PATH})
  # Prefer installing in ~/bin so we don't need sudo.
  temp=$(filter ${HOME}/bin /usr/local/bin, ${SPACEPATH})
  bindir=$(word 1,${temp})
  # Ideally, we'd check for writability of dirs here, but how?
endif

ifeq (${bindir}, )      # Failsafe if bindir didn't get set above
  bindir=$(prefix)/bin
endif


usage:
	@echo "Type 'make install' to install Zool to ${bindir}."
	@echo "Type 'make uninstall' to remove it."
	@echo
	@echo "To install in a different directory, "
	@echo "type 'make bindir=/some/other/directory install'."
	@echo
install:
	cp -a zool ${bindir}
	cp -a zool.desktop ${HOME}/.local/share/applications/
	xdg-mime default ${HOME}/.local/share/applications/zool.desktop x-scheme-handler/zoommtg

uninstall:
	rm -f ${HOME}/.local/share/applications/zool.desktop
	rm -f /usr/local/bin/zool
	xdg-mime query default x-scheme-handler/zoommtg
