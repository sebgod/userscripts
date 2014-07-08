PROJ_NAME := $(notdir $(shell pwd))
DOT_FILES := .gitignore .gitattributes
SCRIPTS := build.cmd results.cmd build.sh
HARDLINK := ln -f -T

.PHONY: update
update: $(DOT_FILES) $(SCRIPTS) LICENSE
	@echo Updated existing files in $(PROJ_TYPE):$(PROJ_NAME)

build.cmd: $(CMD_DIR)/mmcmake.cmd
	$(HARDLINK) $< $@

results.cmd: $(TMPL_DIR)/results.cmd convert_utf8to16.cmd empty_utf16le_bom.txt
	$(HARDLINK) $< $@

%.cmd: $(CMD_DIR)/%.cmd
	$(HARDLINK) $< $@

%.sh: $(TMPL_DIR)/%.sh
	$(HARDLINK) $< $@

.%: $(TMPL_DIR)/_%.tmpl
	$(HARDLINK) $< $@

empty_%.txt: $(CMD_DIR)/empty_%.txt
	$(HARDLINK) $< $@

%: $(TMPL_DIR)/%.tmpl
	$(HARDLINK) $< $@

.PHONY: init
init: update
	@mkdir -p src
	@echo Initialised $(PROJ_TYPE):$(PROJ_NAME) with template in $(TMPL_DIR)

