#!/usr/bin/env python3
"""Check that the Arabic CircuitJS1 Pages bundle is complete before deployment."""
from pathlib import Path
import re
import sys

root = Path(__file__).resolve().parents[1]
site = root / "site"
required = [
    "index.html", "circuitjs.html", "iframe.html", "LICENSE.txt", "lz-string.min.js",
    "font/fontello.css", "circuitjs110/circuitjs1.nocache.js",
    "circuitjs110/AA6F3F7044684ABA62EF9B8A2BE1EFF3.cache.js",
    "circuitjs110/D14AD8A4F69CFF4BCBF19C05960D174F.cache.js",
    "circuitjs110/locale_ar.txt", "circuitjs110/setuplist.txt",
    "circuitjs110/circuits/ohms.txt", "circuitjs110/circuits/capac.txt",
    "circuitjs110/circuits/xor.txt",
]
missing = [entry for entry in required if not (site / entry).is_file()]
if missing:
    print("Missing required assets:", ", ".join(missing), file=sys.stderr)
    raise SystemExit(1)

locale = (site / "circuitjs110/locale_ar.txt").read_text(encoding="utf-8")
entries = re.findall(r'^"(.*)"="(.*)"$', locale, re.M)
if len(entries) < 460:
    print("Arabic localization is incomplete.", file=sys.stderr)
    raise SystemExit(1)
for source, translated in entries:
    if not translated.strip():
        print(f"Empty translation for {source!r}", file=sys.stderr)
        raise SystemExit(1)

index = (site / "index.html").read_text(encoding="utf-8")
simulator = (site / "circuitjs.html").read_text(encoding="utf-8")
if "circuitjs.html?lang=ar" not in index or "circuitjs110/circuitjs1.nocache.js" not in simulator:
    print("Arabic launch or simulator entry point is missing.", file=sys.stderr)
    raise SystemExit(1)
print(f"PASS: {len(entries)} Arabic localization entries and all required simulator assets.")
