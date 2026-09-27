#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$DIR/../source/_raw"

# Create source/raw directory
mkdir -p "$SRC"

# Ensure source/_raw is not empty
[[ -z "$(ls -A "$SRC" 2>/dev/null)" ]] && exit 1

# Handle svg images
for svg in "$SRC"/*.svg; do
	filename=$(basename "$svg")
	# sed 's|<svg\([^>]*\)>|<svg\1><style>@media(prefers-color-scheme:dark){path{fill:white}}</style>|' "$svg" >"$DIR/../source/$filename"
	mv "$svg" "$DIR/../source/$filename"
	svgo --quiet "$DIR/../source/$filename"
	echo "$filename"
done