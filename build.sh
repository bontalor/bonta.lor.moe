#!/bin/bash

# --- Git Info ---
GIT_COMMIT=$(git rev-parse HEAD)           # full 40-char SHA
GIT_COMMIT_SHORT=${GIT_COMMIT:0:7}        # first 7 hex digits
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
BUILD_DATE=$(date +"%Y-%m-%d %H:%M:%S")
BUILD_HOST=$(hostname)

# --- Convert short SHA (7 hex digits) to decimal ---
DEC=$((16#$GIT_COMMIT_SHORT))

# --- Convert decimal to trinary (base-3) keeping MSB on the left ---
TRINARY=""
n=$DEC
while [ $n -gt 0 ]; do
    TRINARY="$(( n % 3 ))$TRINARY"
    n=$(( n / 3 ))
done

# --- Pad TRINARY to 17 trits (like Rust dollcode for 7 hex digits) ---
TRINARY=$(printf "%017d" "$TRINARY")

# --- Map trits to dollcode glyphs ---
DOLLCODE=$(echo "$TRINARY" | sed -e 's/0/▖/g' -e 's/1/▘/g' -e 's/2/▌/g')

# --- Write to Jekyll data file ---
mkdir -p _data
cat > _data/git.yml <<EOF
commit: "$GIT_COMMIT"
commit_short: "$GIT_COMMIT_SHORT"
branch: "$GIT_BRANCH"
build_date: "$BUILD_DATE"
build_host: "$BUILD_HOST"
dollcode: "$DOLLCODE"
EOF

# --- Build site ---
bundle exec jekyll build
