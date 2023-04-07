#!/bin/sh
#
cargo clippy --fix --allow-staged -- \
-W clippy::pedantic \
-W clippy::nursery \
-A clippy::cast_precision_loss \
-A clippy::cast_sign_loss \
-A clippy::cast_possible_truncation \
-A clippy::cast_possible_wrap

# -W clippy::cargo \
