#!/bin/bash

GIT_COMMIT=$(git rev-parse HEAD)
GIT_COMMIT_SHORT=$(git rev-parse --short HEAD)
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
BUILD_DATE=$(date +"%Y-%m-%d %H:%M:%S")
BUILD_HOST=$(hostname)

cat > _data/git.yml <<EOF
commit: "$GIT_COMMIT"
commit_short: "$GIT_COMMIT_SHORT"
branch: "$GIT_BRANCH"
build_date: "$BUILD_DATE"
build_host: "$BUILD_HOST"
EOF

bundle exec jekyll build
