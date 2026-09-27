#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$DIR/../source"
RME="$DIR/../README.md"
MAX=5

# Create table
out="<!-- START_TABLE -->\n<table>\n" && i=0
for f in "$SRC"/*.svg; do
	name="$(basename "$f")"
	[ $((i % MAX)) -eq 0 ] && out+="  <tbody><tr>\n"
	out+="    <td align=\"center\" width=\"99999\"><img src=\"source/$name\" align=\"center\" width=\"56\"></td>\n"
	i=$((i + 1))
	[ $((i % MAX)) -eq 0 ] && out+="  </tr></tbody>\n"
done
[ $((i % MAX)) -ne 0 ] && out+="  </tr></tbody>\n"
out+="</table>\n<!-- CEASE_TABLE -->"

# Inject table
awk -v t="$out" '
  /<!-- START_TABLE -->/ { printf "%s\n", t; skip=1; next }
  /<!-- CEASE_TABLE -->/ { skip=0; next }
  !skip
' "$RME" >"$RME.tmp" && mv "$RME.tmp" "$RME"