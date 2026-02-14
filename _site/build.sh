#!/bin/bash
set -e

# --- Git Info ---
GIT_COMMIT=$(git rev-parse HEAD)
GIT_COMMIT_SHORT=$(git rev-parse --short HEAD)
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
BUILD_DATE=$(date +"%Y-%m-%d %H:%M:%S")
BUILD_HOST=$(hostname)

# --- Convert short SHA to decimal ---
DECIMAL=$((16#$GIT_COMMIT_SHORT))

# --- Generate dollcode using Python ---
DOLLCODE=$(python3 - <<END
chars = ["▌","▖","▘"]
number = $DECIMAL
out = []
window = number
loop_protection = 1000

while window > 0 and loop_protection > 0:
    mod = window % 3
    if mod == 0:
        window = (window - 3)//3
    else:
        window = (window - mod)//3
    out.insert(0, chars[mod])
    loop_protection -= 1

print("".join(out))
END
)

# --- Write to Jekyll _data ---
mkdir -p _data
cat > _data/git.yml <<EOF
commit: "$GIT_COMMIT"
commit_short: "$GIT_COMMIT_SHORT"
branch: "$GIT_BRANCH"
build_date: "$BUILD_DATE"
build_host: "$BUILD_HOST"
dollcode: "$DOLLCODE"
EOF

# --- Build Jekyll site ---
bundle exec jekyll build
