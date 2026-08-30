#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " Neovim Java/Spring Boot Bootstrap"
echo "======================================"
echo

NVIM_CONFIG="$HOME/.config/nvim"

if [[ ! -d "$NVIM_CONFIG" ]]; then
    echo "ERROR: Neovim configuration not found:"
    echo "       $NVIM_CONFIG"
    exit 1
fi

echo "==> Checking required commands..."

for cmd in nvim java mvn curl unzip; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "ERROR: '$cmd' is not installed."
        exit 1
    fi

    echo "    ✓ $cmd"
done

echo
echo "==> Java:"
java -version

echo
echo "==> Maven:"
mvn -version | head -5

echo
echo "==> Installing Java Test..."

"$NVIM_CONFIG/scripts/install-java-test.sh"

echo
echo "======================================"
echo " Bootstrap completed successfully"
echo "======================================"
