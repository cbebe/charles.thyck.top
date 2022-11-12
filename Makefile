UPDATED=$(shell git log -1 --pretty="format:%cs" static/Resume.pdf)

build:
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo

serve:
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo serve -D

%: bin/%/main.go
	go run $<
