PROJ_NAME := $(notdir $(shell pwd))
DOT_FILES := .gitignore .gitattributes
SCRIPTS := build.cmd results.cmd build.sh results.sh
HARDLINK := ln -f -T

.PHONY: update
update: $(DOT_FILES) $(SCRIPTS) LICENSE Makefile Make.options
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

.PHONY: init
init: update
	@mkdir -p src
	@mkdir -p tools
	@mkdir -p tests
	@echo Initialised $(PROJ_TYPE):$(PROJ_NAME) with template in $(TMPL_DIR)

