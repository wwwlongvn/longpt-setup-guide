#!/bin/bash
# Prepare docs/ folder for MkDocs build by copying markdown files from root.
# Root structure stays Obsidian-friendly; docs/ is generated, not committed.
#
# Usage: ./scripts/build-docs.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$ROOT_DIR"

echo "→ Cleaning docs/"
rm -rf docs
mkdir -p docs

echo "→ Copying README.md as homepage (index.md)"
cp README.md docs/index.md

echo "→ Copying 7 content folders"
for dir in 00-triet-ly 01-cai-dat 02-vault-dau-tien-brain 03-mo-rong-multi-vault 04-agents-skills-memory 05-bao-tri-lint 99-templates; do
  if [ -d "$dir" ]; then
    cp -r "$dir" "docs/"
    echo "  ✓ $dir"
  fi
done

echo "→ Copying assets/ for extra CSS"
if [ -d "assets" ]; then
  cp -r assets docs/
fi

echo "✓ docs/ ready. Run: mkdocs build  or  mkdocs serve"
