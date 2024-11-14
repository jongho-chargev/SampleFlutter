#!/bin/sh
branch_name=$(git symbolic-ref --short HEAD)
echo $branch_name

issue_type=$(echo "$branch_name" | awk -F'[-/]' '{print $1}')
issue_num=$(echo "$branch_name" | awk -F'[-/]' '{print $3}')
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

# Notion API 토큰
token="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"

# 페이지 ID
database_id="13c5b5920009806b83b8e35d7d7eece5"

# 추가할 텍스트
text="Hello from Bash!"

# HTTP 요청 URL
url_query="https://api.notion.com/v1/databases/$database_id/query"


# HTTP 요청 헤더
headers=( 
    "Authorization: Bearer $token" 
    "Content-Type: application/json" 
    "Notion-Version: 2022-06-28" 
)
header_args=() 
for header in "${headers[@]}"; do 
echo $header
    header_args+=(-H "$header") 
    echo "${header_args[@]}"
done
        

# HTTP 요청 본문
data='{
    "filter": {
        "property": "ID",
        "number": {
            "equals": '$issue_num'
        }
    }
}'

# curl 명령 실행
echo "$headers" -d "$data" "$url_query"
response=$(curl -X POST "${header_args[@]}" -d "$data" "$url_query")
# echo "response $response"

# JSON 응답에서 Page ID 추출
_page_id=$(echo "$response" | grep -o '"object":"page","id":"[^"]*' | sed 's/.*"id":"\([^"]*\)".*/\1/')
_page_id=$(echo '{print "'$response'"}' | grep -o '"object":"page","id":"[^"]*' | sed 's/.*"id":"\([^"]*\)".*/\1/')

page_id=$(echo '{print "'$_page_id'"}'| sed 's/.*"id":"\([^"]*\)".*/\1/' | sed 's/-//g')

echo "page_id $page_id"

current_commit=$(git rev-parse HEAD)
echo "current_commit $current_commit"

url="https://api.notion.com/v1/blocks/$page_id/children"
echo "url $url"

body='{
    "children": [
        {
            "paragraph": {
                "rich_text": [
                    {
                        "type": "text",
                        "text": {
                            "content": "소스가 반영되었습니다."
                        }
                    }
                ]
            }
        },
        {
      "bookmark": {
        "url": "https://github.com/jongho-chargev/SampleFlutter/commit/'$current_commit'"
      }
    }
    ]
}'

response_write=$(curl -X PATCH "${header_args[@]}" -d "$body" "$url")
echo $response_write



body='{
    "properties": {
        "상태" :{
            "type": "status",
            "status": {
                "name": "개발완료"
            }
        }
    }
}'
url="https://api.notion.com/v1/pages/$page_id"
echo "url $url"
response_write=$(curl -X PATCH "${header_args[@]}" -d "$body" "$url")
echo $response_write

