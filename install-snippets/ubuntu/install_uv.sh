#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Installing uv (Python package manager)..."
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "uv installation complete!"
