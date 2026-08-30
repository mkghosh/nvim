#!/usr/bin/env bash

set -euo pipefail

VERSION="$(
    sed -n 's/.*java_test = "\([^"]*\)".*/\1/p' \
        "$HOME/.config/nvim/lua/lsp/servers/jdtls/versions.lua"
)"

BASE="$HOME/.local/share/nvim/java-test-$VERSION"
TMP="$(mktemp -d)"

trap 'rm -rf "$TMP"' EXIT

URL="https://open-vsx.org/api/vscjava/vscode-java-test/$VERSION/file/vscjava.vscode-java-test-$VERSION.vsix"

echo "==> Installing vscode-java-test $VERSION"
echo "==> Download: $URL"

curl -fL --retry 3 \
    -o "$TMP/java-test.vsix" \
    "$URL"

echo "==> Extracting server files..."

rm -rf "$BASE"

mkdir -p "$BASE"

unzip -q \
    "$TMP/java-test.vsix" \
    'extension/server/*' \
    -d "$BASE"

echo
echo "==> Installed Java Test $VERSION"
echo

find "$BASE/extension/server" \
    -maxdepth 1 \
    -type f \
    -printf '%f\n' |
    sort
