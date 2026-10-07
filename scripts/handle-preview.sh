#!/usr/bin/env bash

set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$DIR/../source"
OUT="$DIR/../.assets/preview-01.avif"
TMP="$(mktemp -d)"

mapfile -t ALL < <(find "$SRC" -maxdepth 2 -name "*.svg" | shuf -n 32)
for NUM in "${!ALL[@]}"; do
	PNG="${ALL[$NUM]}"
	COL=$([ $(((NUM / 8) % 2)) -eq 0 ] && { [ $((NUM % 2)) -eq 0 ] && echo "#abacae" || echo "#333333"; } || { [ $((NUM % 2)) -eq 0 ] && echo "#333333" || echo "#abacae"; })
	magick -background none "$PNG" \
		-strip \
		-resize 160x160! \
		-bordercolor "$COL" \
		-border 48x24 \
		"$TMP/$(printf '%02d' $((NUM+1))).png"
done

{ magick montage -background none "$TMP"/*.png -tile 8x4 -geometry +0+0 png:- | avifenc --stdin --input-format png "$OUT"; } || true