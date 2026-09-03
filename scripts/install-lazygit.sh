#!/usr/bin/env bash

set -euo pipefail

LAZYGIT_VERSION="0.64.1"
INSTALL_DIR="$HOME/.local/bin"
BINARY="$INSTALL_DIR/lazygit"

echo "==> LazyGit version: $LAZYGIT_VERSION"

mkdir -p "$INSTALL_DIR"

# --------------------------------------------------------------------------
# Check existing installation
# --------------------------------------------------------------------------

if [[ -x "$BINARY" ]]; then
    INSTALLED_VERSION="$("$BINARY" --version 2>/dev/null |
        awk '{print $3}' || true)"

    if [[ "$INSTALLED_VERSION" == "$LAZYGIT_VERSION" ]]; then
        echo "==> LazyGit $LAZYGIT_VERSION is already installed."
        echo "    $BINARY"
        exit 0
    fi

    echo "==> Existing LazyGit version: ${INSTALLED_VERSION:-unknown}"
    echo "==> Updating to LazyGit $LAZYGIT_VERSION..."
fi

# --------------------------------------------------------------------------
# Detect architecture
# --------------------------------------------------------------------------

ARCH="$(uname -m)"

case "$ARCH" in
x86_64)
    LAZYGIT_ARCH="x86_64"
    ;;

aarch64 | arm64)
    LAZYGIT_ARCH="arm64"
    ;;

*)
    echo "ERROR: Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

# --------------------------------------------------------------------------
# Detect operating system
# --------------------------------------------------------------------------

OS="$(uname -s)"

case "$OS" in
Linux)
    LAZYGIT_OS="Linux"
    ;;

Darwin)
    LAZYGIT_OS="Darwin"
    ;;

*)
    echo "ERROR: Unsupported operating system: $OS"
    exit 1
    ;;
esac

# --------------------------------------------------------------------------
# Download
# --------------------------------------------------------------------------

TMP_DIR="$(mktemp -d)"

trap 'rm -rf "$TMP_DIR"' EXIT

ARCHIVE="lazygit_${LAZYGIT_VERSION}_${LAZYGIT_OS}_${LAZYGIT_ARCH}.tar.gz"

URL="https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/${ARCHIVE}"

echo "==> Downloading LazyGit..."
echo "    $URL"

curl -fL --retry 3 \
    -o "$TMP_DIR/$ARCHIVE" \
    "$URL"

# --------------------------------------------------------------------------
# Extract
# --------------------------------------------------------------------------

echo "==> Extracting LazyGit..."

tar -xzf "$TMP_DIR/$ARCHIVE" \
    -C "$TMP_DIR"

if [[ ! -f "$TMP_DIR/lazygit" ]]; then
    echo "ERROR: LazyGit binary was not found after extraction."
    exit 1
fi

# --------------------------------------------------------------------------
# Install
# --------------------------------------------------------------------------

install -m 0755 \
    "$TMP_DIR/lazygit" \
    "$BINARY"

# --------------------------------------------------------------------------
# Verify
# --------------------------------------------------------------------------

echo
echo "==> LazyGit installed successfully:"
"$BINARY" --version

echo
echo "    Binary:"
echo "    $BINARY"

# --------------------------------------------------------------------------
# PATH check
# --------------------------------------------------------------------------

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo
    echo "WARNING: $INSTALL_DIR is not in PATH."
    echo
    echo "Add this to ~/.bashrc:"
    echo
    echo '    export PATH="$HOME/.local/bin:$PATH"'
fi
