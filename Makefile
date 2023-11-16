WASM_PACK:=$(shell command -v wasm-pack 2> /dev/null)
WASM_OPT:=$(shell command -v wasm-opt 2> /dev/null)
HUGO:=$(shell command -v hugo 2> /dev/null)

build: assets/turnip.html themes/risotto/theme.toml
	hugo --minify

watch: assets/turnip.html
	hugo serve -D

themes/risotto/theme.toml:
	git submodule init && git submodule update

clean:
	rm -f *.aux *.log *.out Resume-*.tex

pages: turnip build deploy

assets/turnip.html:
	@$(MAKE) turnip

turnip: turnip/node_modules
ifndef WASM_PACK
  $(error "wasm-pack is not available. please run `cargo install wasm-pack`.")
endif
ifndef WASM_OPT
  $(error "wasm-opt is not available. please run `cargo install wasm-opt`.")
endif
	cd turnip && pnpm prebuild && pnpm build
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
