#!/usr/bin/env bash

scarb build && \
cargo run --release --bin runner -- ./target/dev/cairo_verifier.sierra.json < ./examples/proofs/example_proof.json
