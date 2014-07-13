include ../Make.options
include ../Project.options

TEST_MODULES:=$(wildcard *.m)
MODULES:=$(TEST_MODULES) $(wildcard ../src/*.m)
EXPS:=$(wildcard *.exp)
TESTS:=$(patsubst test_%.m,test_%,$(TEST_MODULES))
DIFFS:=$(patsubst %.exp,%.diff,$(EXPS))
RESS:=$(patsubst %.exp,%.res,$(EXPS))

.PHONY: runtests
runtests:  compile $(RESS)

%.res: %.exp
	@./run_test.sh "test_$(PROJ_CNAME)" "$*" >"$@"
	@( $(DIFF) $(DIFF_FLAGS) $*.exp $@ 1>$*.diff && \
		echo $*>>SUCCESS) || ( echo $*>>FAILED )

.PHONY: runtests-verbose
runtests-verbose: runtests
	@echo "@@ SUCCESS" && cat SUCCESS
	@echo "@@ FAILED" && cat FAILED

Mercury.modules: $(MODULES)
	@$(MMC) -f $^
	@echo cleaning up for testing
	rm -f $(RESS)

tags: $(MODULES)
	$(MTAGS) $^

.PHONY: compile
compile: Mercury.modules
	@rm -f SUCCESS && touch SUCCESS
	@rm -f FAILED  && touch FAILED
	@$(foreach test,$(TESTS),$(MMC) --make $(test);)

.PHONY: clean
clean:
	@$(foreach test,$(TESTS),$(MMC) --make $(test).clean;)
	rm -f $(RESS)

.PHONY: realclean
realclean:
	@$(foreach test,$(TESTS),$(MMC) --make $(test).realclean;)
	rm -f $(DIFFS)
	rm -f $(RESS)
	rm -rf Mercury
	rm -f *.log
	rm -f Mercury.modules
