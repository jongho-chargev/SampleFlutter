#!/bin/sh

# Git 리포지토리 초기화
git init

# prepare-commit-msg 훅 스크립트 작성
cat << 'EOF' > .git/hooks/prepare-commit-msg
#!/bin/sh

# 현재 브랜치명 가져오기
branch_name=$(git symbolic-ref --short HEAD)

# 브랜치명에서 issue-번호 추출 (예: issue-3)
issue_number=$(echo "$branch_name" | grep -oE 'issue-[0-9]+')

# 커밋 메시지 파일 경로
commit_msg_file=$1

# 커밋 메시지 앞에 [issue-번호] 추가
if [ -n "$issue_number" ]; then
    sed -i.bak -e "1s/^/[$issue_number] /" "$commit_msg_file"
fi
EOF

# prepare-commit-msg 훅에 실행 권한 부여
chmod +x .git/hooks/prepare-commit-msg

chmod +x .git/hooks/post-receive

chmod +x .git/hooks/pre-push

chmod +x .git/hooks/post-update

echo "Git repository initialized and prepare-commit-msg hook set up."
