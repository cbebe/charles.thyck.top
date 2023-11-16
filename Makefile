WASM_PACK:=$(shell command -v wasm-pack 2> /dev/null)
HUGO:=$(shell command -v hugo 2> /dev/null)

build: assets/turnip.html
	hugo --minify

watch: assets/turnip.html
	hugo serve -D

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
	cd turnip && pnpm postbuild

turnip/node_modules:
	cd turnip && pnpm install

turnip-dev: turnip/turnips.html
	cd turnip && pnpm start

turnip/turnips.html: public/turnip/index.html
	./bin/make-turnip.sh $< $@

public/turnip/index.html:
	@$(MAKE) build

.PHONY: pages build watch turnip turnip-dev clean

%: bin/%/main.go
	go run $<
