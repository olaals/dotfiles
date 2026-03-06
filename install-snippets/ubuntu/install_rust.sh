#!/bin/bash
# 1) install curl if the VM doesn't have it
sudo apt update
sudo apt install -y curl build-essential

# 2) install rustup (Rust + Cargo)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 3) load cargo into the current shell
source $HOME/.cargo/env

# 4) verify
rustc --version
cargo --version
