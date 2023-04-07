UPDATED:=$(shell git log -1 --pretty="format:%cs" static/Resume.pdf)
WASM_PACK:=$(shell command -v wasm-pack 2> /dev/null)
HUGO:=$(shell command -v hugo 2> /dev/null)

build: data/packages.md assets/turnip.html
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo --minify

watch: data/packages.md assets/turnip.html
	HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) hugo serve -D

clean:
	rm -f *.aux *.log *.out Resume-*.tex

pages: turnip build deploy

assets/turnip.html:
	@$(MAKE) turnip

turnip: turnip/node_modules
ifndef WASM_PACK
  $(error "wasm-pack is not available. please run `cargo install wasm-pack`.")
endif
	cd turnip && pnpm build
	rm -rf static/assets
	mv turnip/dist/index.html assets/turnip.html
	mv turnip/dist/assets static/

turnip/node_modules:
	cd turnip && pnpm install

turnip-dev: turnip/turnips.html
	cd turnip && pnpm start

turnip/turnips.html: public/turnip/index.html
	./bin/make-turnip.sh $< $@

public/turnip/index.html:
	@$(MAKE) build

.PHONY: pages build watch resume turnip turnip-dev

%: bin/%/main.go
	@HUGOxPARAMSxGIT_LAST_UPDATED=$(UPDATED) go run $<

# Not a prerequesite otherwise it would run every time
data/packages.md:
	@$(MAKE) packages

resume:
	cd resume && $(MAKE)
	cp -f resume/Resume.pdf static/Resume.pdf
