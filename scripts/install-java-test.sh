#!/usr/bin/env bash

set -euo pipefail

NVIM_CONFIG="$HOME/.config/nvim"

VERSION="$(
    sed -n 's/.*java_test = "\([^"]*\)".*/\1/p' \
        "$NVIM_CONFIG/lua/lsp/servers/jdtls/versions.lua"
)"

if [[ -z "$VERSION" ]]; then
    echo "ERROR: Could not determine java-test version."
    exit 1
fi

BASE="$HOME/.local/share/nvim/java-test-$VERSION"
SERVER="$BASE/extension/server"

VSIX_URL="https://open-vsx.org/api/vscjava/vscode-java-test/$VERSION/file/vscjava.vscode-java-test-$VERSION.vsix"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "==> Java Test version: $VERSION"

###############################################################################
# Already installed?
###############################################################################

if [[ -f "$SERVER/com.microsoft.java.test.plugin-0.43.1.jar" ]] &&
    [[ -f "$SERVER/org.objectweb.asm_9.10.1.jar" ]] &&
    [[ -f "$SERVER/org.objectweb.asm.commons_9.10.1.jar" ]] &&
    [[ -f "$SERVER/org.objectweb.asm.tree_9.10.1.jar" ]] &&
    [[ -f "$SERVER/org.jacoco.core_0.8.15.202606040825.jar" ]]; then

    echo "==> java-test $VERSION is already installed."
    echo "    $BASE"
    exit 0
fi

###############################################################################
# Download
###############################################################################

echo "==> Downloading java-test $VERSION..."

curl -fL --retry 3 \
    -o "$TMP/java-test.vsix" \
    "$VSIX_URL"

###############################################################################
# Validate
###############################################################################

echo "==> Validating VSIX..."

if ! file "$TMP/java-test.vsix" | grep -q "Zip archive"; then
    echo "ERROR: Downloaded file is not a valid VSIX/ZIP archive."
    exit 1
fi

###############################################################################
# Extract
###############################################################################

echo "==> Installing java-test $VERSION..."

rm -rf "$BASE"

mkdir -p "$BASE"

unzip -q \
    "$TMP/java-test.vsix" \
    'extension/server/*' \
    -d "$BASE"

###############################################################################
# Verify
###############################################################################

echo "==> Verifying installation..."

required_files=(
    "com.microsoft.java.test.plugin-0.43.1.jar"
    "org.objectweb.asm_9.10.1.jar"
    "org.objectweb.asm.commons_9.10.1.jar"
    "org.objectweb.asm.tree_9.10.1.jar"
    "org.jacoco.core_0.8.15.202606040825.jar"
)

for file in "${required_files[@]}"; do
    if [[ ! -f "$SERVER/$file" ]]; then
        echo "ERROR: Missing required file:"
        echo "       $SERVER/$file"
        exit 1
    fi

    echo "    ✓ $file"
done

echo
echo "==> Java Test $VERSION installed successfully."
echo "    $BASE"
