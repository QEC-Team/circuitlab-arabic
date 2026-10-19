#!/usr/bin/env bash
# Rebuild the self-contained GitHub Pages site from CircuitJS1 and local Arabic assets.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT/.build"
UPSTREAM_DIR="$BUILD_DIR/circuitjs1"
SITE_DIR="$ROOT/site"
FALSTAD_BASE="https://www.falstad.com/circuit"

rm -rf "$BUILD_DIR" "$SITE_DIR"
mkdir -p "$BUILD_DIR" "$SITE_DIR/circuitjs110/gwt/clean" "$SITE_DIR/font"
git clone --depth 1 https://github.com/sharpie7/circuitjs1.git "$UPSTREAM_DIR"

# CircuitJS1 source owns the examples.  Keep every example local to the Pages site.
cp -a "$UPSTREAM_DIR/src/com/lushprojects/circuitjs1/public/circuits" "$SITE_DIR/circuitjs110/"
cp "$UPSTREAM_DIR/src/com/lushprojects/circuitjs1/public/setuplist.txt" "$SITE_DIR/circuitjs110/setuplist.txt"

# Use the current pre-built GWT application.  The locale file is loaded at runtime.
curl --fail --location --retry 3 --silent --show-error "$FALSTAD_BASE/circuitjs110/circuitjs1.nocache.js" -o "$SITE_DIR/circuitjs110/circuitjs1.nocache.js"
curl --fail --location --retry 3 --silent --show-error "$FALSTAD_BASE/circuitjs110/AA6F3F7044684ABA62EF9B8A2BE1EFF3.cache.js" -o "$SITE_DIR/circuitjs110/AA6F3F7044684ABA62EF9B8A2BE1EFF3.cache.js"
curl --fail --location --retry 3 --silent --show-error "$FALSTAD_BASE/circuitjs110/D14AD8A4F69CFF4BCBF19C05960D174F.cache.js" -o "$SITE_DIR/circuitjs110/D14AD8A4F69CFF4BCBF19C05960D174F.cache.js"
curl --fail --location --retry 3 --silent --show-error "$FALSTAD_BASE/circuitjs110/style.css" -o "$SITE_DIR/circuitjs110/style.css"
curl --fail --location --retry 3 --silent --show-error "$FALSTAD_BASE/circuitjs110/gwt/clean/clean.css" -o "$SITE_DIR/circuitjs110/gwt/clean/clean.css"
curl --fail --location --retry 3 --silent --show-error "$FALSTAD_BASE/lz-string.min.js" -o "$SITE_DIR/lz-string.min.js"

for file in fontello.css fontello.eot fontello.svg fontello.ttf fontello.woff fontello.woff2 LICENSE.txt webfontlicense.html; do
  curl --fail --location --retry 3 --silent --show-error "$FALSTAD_BASE/font/$file" -o "$SITE_DIR/font/$file"
done

for file in about.html blink-test.html crystal.html customfunction.html customlogic.html customtransformer.html diodecalc.html mosfet-beta.html opampreal.html subcircuits.html; do
  cp "$UPSTREAM_DIR/war/$file" "$SITE_DIR/$file"
done

cp "$ROOT/assets/index.html" "$SITE_DIR/index.html"
cp "$ROOT/assets/circuitjs.html" "$SITE_DIR/circuitjs.html"
cp "$ROOT/assets/iframe.html" "$SITE_DIR/iframe.html"
cp "$ROOT/assets/locale_ar.txt" "$SITE_DIR/circuitjs110/locale_ar.txt"
cp "$ROOT/LICENSE" "$SITE_DIR/LICENSE.txt"
touch "$SITE_DIR/.nojekyll"
