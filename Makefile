UPDATED=$(shell git log -1 --pretty="format:%cs" static/Resume.pdf)

build:
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo

watch:
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo serve -D

pages: build deploy

.PHONY: pages build watch resume

%: bin/%/main.go
	go run $<

resume: static/Resume.pdf

static/Resume.pdf:
	cd resume && $(MAKE)
	cp resume/Resume.pdf $@
