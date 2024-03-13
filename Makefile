HUGO:=$(shell command -v hugo 2> /dev/null)

build: assets/turnip.html themes/risotto/theme.toml
ifndef HUGO
	CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
endif
	hugo --minify

watch: assets/turnip.html
ifndef HUGO
	CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
endif
	hugo serve -D

themes/risotto/theme.toml:
	git submodule init && git submodule update

clean:
	rm -f *.aux *.log *.out Resume-*.tex

pages: build deploy

assets/turnip.html:
	$(MAKE) -f turnip.make $@

.PHONY: pages build watch turnip turnip-dev clean

%: bin/%/main.go
	go run $<
