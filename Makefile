SHELL = /bin/bash
SUDO ?=

ifneq ($(shell id -u),0)
	SUDO = sudo
endif

.PHONY: all
all:

.PHONY: install
install: install-lib install-bin install-sbin

## {{{ target: install-lib
.PHONY: install-lib
install-lib:
	@pwd='$(shell pwd)';\
	files='$(shell find -L lib -type f)';\
	for file in $$files;\
	do\
	  src="$$pwd/$$file";\
	  dest="/usr/local/$$file";\
	  dest_parent="$$(dirname $$dest)";\
	  [[ -d $$dest_parent ]] || {\
	    echo $(SUDO) install -d $$dest_parent -m0755;\
	  };\
	  [[ -e $$dest ]] && {\
	    echo $(SUDO) rm -f $$dest;\
	    [[ $$? -eq 0 ]] || exit 1;\
	  };\
	  echo $(SUDO) ln -s $$src $$dest;\
	  [[ $$? -eq 0 ]] || exit 1;\
	done
## }}}

## {{{ target: install-bin
.PHONY: install-bin
install-bin:
	@pwd='$(shell pwd)';\
	files='$(shell find -L bin -type f)';\
	for file in $$files;\
	do\
	  src="$$pwd/$$file";\
	  dest="/usr/local/$$file";\
	  dest_parent="$$(dirname $$dest)";\
	  [[ -d $$dest_parent ]] || {\
	    echo $(SUDO) install -d $$dest_parent -m0755;\
	  };\
	  [[ -e $$dest ]] && {\
	    echo $(SUDO) rm -f $$dest;\
	    [[ $$? -eq 0 ]] || exit 1;\
	  };\
	  echo $(SUDO) ln -s $$src $$dest;\
	  [[ $$? -eq 0 ]] || exit 1;\
	done
## }}}

## {{{ target: install-sbin
.PHONY: install-sbin
install-sbin:
	@pwd='$(shell pwd)';\
	files='$(shell find -L sbin -type f)';\
	for file in $$files;\
	do\
	  src="$$pwd/$$file";\
	  dest="/usr/local/$$file";\
	  dest_parent="$$(dirname $$dest)";\
	  [[ -d $$dest_parent ]] || {\
	    echo $(SUDO) install -d $$dest_parent -m0755;\
	  };\
	  [[ -e $$dest ]] && {\
	    echo $(SUDO) rm -f $$dest;\
	    [[ $$? -eq 0 ]] || exit 1;\
	  };\
	  echo $(SUDO) ln -s $$src $$dest;\
	  [[ $$? -eq 0 ]] || exit 1;\
	done
## }}}

##
# vim: ts=2 sw=2 noet fdm=marker :
##
