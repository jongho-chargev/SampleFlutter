#!/bin/sh
branch_name=$(git symbolic-ref --short HEAD)
echo $branch_name

issue_type=$(echo "$branch_name" | awk -F'[-/]' '{print $1}')
# 브랜치 타입에 따라 변경

case "$issue_type" in 
    feature) 
    issue_type="feat" 
    ;;
    hotfix) 
    issue_type="fix" 
    ;; 
    *) 
    issue_type="" 
    ;; 
esac 
echo "변경된 브랜치 타입: $issue_type"

issue_number=$(echo "$branch_name" | awk -F'[-/]' '{print "'$issue_type'("$2"-"$3")"}')
echo $issue_number


