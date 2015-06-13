OWN_REPOS := \
	diffs \
	docker-mercury \
	docker-mercury-bootstrap \
	docker-mercury-depend \
	docker-mercury-stable \
	docker-mercury-stable-cross \
	grmc \
	userscripts \
	mercury-mongoose \
	mercury-slre \
	mpm \
	shift-reduce \
	skat \
	si-units
FORKS := \
	mercury \
	mercury-csv \
	mercury-json \
	mongoose \
	node-java \
	slre \
	swig \
	the_silver_searcher \
	tidy-html5

.DEFAULT: default
default: forks own_repos
	
.PHONY: forks
forks:
	@$(foreach REPO,$(FORKS),\
		pushd $(REPO); \
		git checkout master && git up && git ff && git merge upstream/master; \
		git push; \
		popd; \
	)
.PHONY: own_repos
own_repos:
	@$(foreach REPO,$(OWN_REPOS),\
		pushd $(REPO); \
		git checkout master && git up && git ff && git push ; \
		popd; \
	)
