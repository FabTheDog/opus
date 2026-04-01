#!/usr/bin/env bash
set -euo pipefail

git remote add upstream https://gitlab.xiph.org/xiph/opus.git 2>/dev/null || true
git fetch upstream

diff_output=$(git diff $(git merge-base master upstream/main)..master \
    --diff-filter=d \
    ':(exclude)README.md' \
    ':(exclude)build.zig' \
    ':(exclude)build.zig.zon' \
    ':(exclude)update.sh' \
    ':(exclude)verify.sh' \
    ':(exclude).forgejo' \
    ':(exclude).gitignore')

if [ -n "$diff_output" ]; then
    echo "$diff_output"
    exit 1
else
    echo "(no diff compared to upstream)"
fi
