PROJ_NAME := $(notdir $(shell pwd))
PROJ_CNAME := $(subst -,_,$(PROJ_NAME))
DOT_FILES := .gitignore .gitattributes
SCRIPTS := build.cmd results.cmd build.sh results.sh
HARDLINK := ln -f -T
FOLDERS := tools doc

.PHONY: update
update: folders $(DOT_FILES) $(SCRIPTS) LICENSE Makefile Make.options
	@echo Updated existing files in $(PROJ_TYPE):$(PROJ_NAME)

build.cmd: $(CMD_DIR)/mmcmake.cmd
	$(HARDLINK) $< $@

results.cmd: $(TMPL_DIR)/results.cmd tools/convert_utf8to16.cmd tools/.empty_utf16le_bom.txt
	$(HARDLINK) $< $@

tools/%.cmd: $(CMD_DIR)/%.cmd
	$(HARDLINK) $< $@

%.sh: $(TMPL_DIR)/%.sh
	$(HARDLINK) $< $@

.%: $(TMPL_DIR)/_%.tmpl
	$(HARDLINK) $< $@

tools/.empty_%.txt: $(CMD_DIR)/.empty_%.txt
	$(HARDLINK) $< $@

%: $(TMPL_DIR)/%.tmpl
	$(HARDLINK) $< $@

.PHONY: folders
folders:
	@for folder in $(FOLDERS) ; do mkdir -p $$folder ; done

.PHONY: init
init: src/.gitignore tests/.gitignore update Project.options
	@echo Initialised $(PROJ_TYPE):$(PROJ_NAME) with template in $(TMPL_DIR)

Project.options:
	@echo "PROJ_CNAME:=$(PROJ_CNAME)">$@
	@echo "PROJ_LIBNAME:=lib\$$(PROJ_CNAME)">>$@

%/.gitignore:
	@mkdir -p $*
	@touch $*/.gitignore
	@for file in "$(TMPL_DIR)/$*/*" ; do \
		cp "$(TMPL_DIR)/$*/$$(basename $$file)" $* ; \
	done
