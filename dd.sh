#!/bin/bash

# 현재 HEAD의 정보를 얻습니다
commit_info=$(git show HEAD --pretty=format:"%d" --no-patch)
echo "commit_info: $commit_info\n"

# 브랜치 이름 추출
# branches=$(echo $commit_info | grep -oP '(?<=\().*?(?=\))' | tr ',' '\n' | tr -d ' ')
branches=$(echo "$commit_info" | sed -n 's/.*(\(.*\)).*/\1/p' | tr ',' '\n' | tr -d ' ')

echo "branches: $branches\n"

# 필요한 브랜치 정보 추출
develop_branch=$(echo "$branches" | grep -o 'develop' | head -n 1)
feature_branch=$(echo "$branches" | grep -o 'ISSUE[^ ]*' | head -n 1)

# 결과 출력
echo "Develop Branch: $develop_branch"
echo "Feature Branch: $feature_branch"
