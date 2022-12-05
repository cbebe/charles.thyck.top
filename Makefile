UPDATED=$(shell git log -1 --pretty="format:%cs" static/Resume.pdf)

build: data/packages.md
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo --minify

watch: data/packages.md
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo serve -D

pages: build deploy

turnip: turnip/turnips.html
	cd turnip && pnpm start

turnip/turnips.html: public/turnip/index.html
	cp $< $@

turnip-build:
	cd turnip && pnpm build
	rm -rf static/assets
	mv turnip/dist/index.html assets/turnip.html
	mv turnip/dist/assets static/

public/turnip/index.html:
	@$(MAKE) build

.PHONY: pages build watch resume turnip

%: bin/%/main.go
	@go run $<

# Not a prerequesite otherwise it would run every time
data/packages.md:
	@$(MAKE) packages

resume: static/Resume.pdf

static/Resume.pdf:
	cd resume && $(MAKE)
	cp resume/Resume.pdf $@
