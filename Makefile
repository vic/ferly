REBAR ?= "$(CURDIR)/rebar"
PREFIX ?= /usr/local
DOCS := master
ELIXIRC := bin/ferly --verbose --ignore-module-conflict
ERLC := erlc -I lib/ferly/include
ERL := erl -I lib/ferly/include -noshell -pa lib/ferly/ebin
VERSION := $(strip $(shell cat VERSION))
Q := @
LIBDIR := lib
INSTALL = install
INSTALL_DIR = $(INSTALL) -m755 -d
INSTALL_DATA = $(INSTALL) -m644
INSTALL_PROGRAM = $(INSTALL) -m755

.PHONY: compile early test
.NOTPARALLEL: compile

define REBAR_APP_TEMPLATE
compile_$(1):
	$(Q) cd lib/$(1) && $(REBAR) compile

test_$(1): compile_$(1)
	$(Q) cd lib/$(1) && $(REBAR) eunit
endef

$(eval $(call REBAR_APP_TEMPLATE,early))

default: compile

compile: compile_early

test: test_early 
