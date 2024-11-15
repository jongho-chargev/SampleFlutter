#!/bin/sh

branch_name=$(git symbolic-ref --short HEAD)
echo $branch_name

issue_type=$(echo "$branch_name" | awk -F'[-/]' '{print $1}')
issue_name=$(echo "$branch_name" | awk -F'/' '{print $2}' | awk -F'-' '{print $1}')
issue_num=$(echo "$branch_name" | awk -F'[-/]' '{print $3}')

echo $issue_type $issue_name $issue_num

case "$issue_type" in 
    feature) 
    issue_type="feat" 
    ;;
    hotfix)
    issue_type="fix" 
    ;; 
    bugfix)
    issue_type="fix" 
    ;; 
    *) 
    issue_type="" 
    ;; 
esac 
echo "변경된 브랜치 타입: $issue_type"





