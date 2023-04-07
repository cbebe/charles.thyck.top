wasm:
	wasm-pack build --target web
	wasm-opt -Oz -o pkg/predictor_bg.wasm pkg/predictor_bg.wasm
	@ls -lh pkg/predictor_bg.wasm

lint:
	cargo clippy -- \
	-W clippy::pedantic \
	-W clippy::nursery \
	-W clippy::cargo \
	-A clippy::cast_precision_loss \
	-A clippy::cast_sign_loss \
	-A clippy::cast_possible_truncation \
	# -A clippy::cast_possible_wrap
