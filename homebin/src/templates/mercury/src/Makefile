include ../Make.options
include ../Project.options

MODULES:=$(wildcard *.m)

.PHONY: default
default:
	$(MMC) $(MCFLAGS) --make $(PROJ_LIBNAME) $(MLLIBS) $(MLCLASSPATH)

.PHONY: rebuild
rebuild:
	$(MMC) --rebuild $(PROJ_LIBNAME) $(MLLIBS) $(MLCLASSPATH)

.PHONY: install
install:
	$(MMC) --make $(PROJ_LIBNAME).install $(MLLIBS) $(MLCLASSPATH)

tags: $(MODULES)
	$(MTAGS) $^

.PHONY: clean
clean:
	$(MMC) --make $(PROJ_CNAME).clean

.PHONY: realclean
realclean:
	$(MMC) --make $(PROJ_CNAME).realclean
	rm -rf Mercury
	rm -f $(wildcard *.err) $(wildcard *.mh)
	rm -f tags
