#!/bin/sh

# 현재 브랜치명 가져오기
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# 병합된 브랜치명을 찾기 위해 ORIG_HEAD를 사용
MERGED_BRANCH=$(git rev-parse --abbrev-ref $(git rev-parse ORIG_HEAD))

echo "현재 브랜치: $CURRENT_BRANCH"
echo "병합된 브랜치: $MERGED_BRANCH"

