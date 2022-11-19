UPDATED=$(shell git log -1 --pretty="format:%cs" static/Resume.pdf)

build: data/packages.md
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo --minify

watch: data/packages.md
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo serve -D

pages: build deploy

.PHONY: pages build watch resume

%: bin/%/main.go
	@go run $<

# Not a prerequesite otherwise it would run every time
data/packages.md:
	@$(MAKE) packages

resume: static/Resume.pdf

static/Resume.pdf:
	cd resume && $(MAKE)
	cp resume/Resume.pdf $@
