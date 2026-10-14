#!/bin/sh
#
# merge_scad.sh
#
# Inlines the `include <Wall_Features.scad>` line in
# "Electronics Box.scad" with the actual file content, producing
# "Electronics Box Onefile.scad". Works around environments/tools
# that only let you load a single .scad file (e.g. some Customizer
# front-ends, or quick sharing of one self-contained file).
#
# Usage:
#   ./merge_scad.sh
#   (expects both .scad files in the current directory, or edit the
#   paths below)
#

set -eu

MAIN_FILE="Electronics Box.scad"
LIB_FILE="Wall_Features.scad"
OUT_FILE="Electronics Box Onefile.scad"

if [ ! -f "$MAIN_FILE" ]; then
    echo "Error: '$MAIN_FILE' not found in current directory." >&2
    exit 1
fi

if [ ! -f "$LIB_FILE" ]; then
    echo "Error: '$LIB_FILE' not found in current directory." >&2
    exit 1
fi

# Match an include/use line referencing Wall_Features.scad, allowing
# for either include<...> or use<...>, with or without a space before
# the angle bracket, and with or without a leading path.
#   e.g.  include <Wall_Features.scad>
#         include<Wall_Features.scad>
#         use <./Wall_Features.scad>
INCLUDE_PATTERN='^[[:space:]]*(include|use)[[:space:]]*<[^>]*Wall_Features\.scad>[[:space:]]*$'

MATCH_COUNT=$(grep -c -E "$INCLUDE_PATTERN" "$MAIN_FILE" || true)

if [ "$MATCH_COUNT" -eq 0 ]; then
    echo "Error: no include/use line for Wall_Features.scad found in '$MAIN_FILE'." >&2
    exit 1
fi

if [ "$MATCH_COUNT" -gt 1 ]; then
    echo "Warning: found $MATCH_COUNT matching include/use lines; all will be replaced." >&2
fi

awk -v libfile="$LIB_FILE" '
BEGIN {
    pattern = "^[ \t]*(include|use)[ \t]*<[^>]*Wall_Features\\.scad>[ \t]*$"
}
$0 ~ pattern {
    print "// ---- begin inlined content of " libfile " ----"
    while ((getline line < libfile) > 0) {
        print line
    }
    close(libfile)
    print "// ---- end inlined content of " libfile " ----"
    next
}
{ print }
' "$MAIN_FILE" > "$OUT_FILE"

echo "Wrote '$OUT_FILE' ($(wc -l < "$OUT_FILE") lines)."
