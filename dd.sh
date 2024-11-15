#!/bin/bash
IS_USE_COMMENT=true
# Notion API 토큰
token="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"

# 페이지 ID
database_id="13c5b5920009806b83b8e35d7d7eece5"

# 현재 HEAD의 정보를 얻습니다
commit_info=$(git show --pretty=format:"%d" --no-patch)
author=$(git show HEAD --pretty=format:"%an" --no-patch)
echo "commit_info: $commit_info\n"

# 브랜치 이름 추출
# branches=$(echo $commit_info | grep -oP '(?<=\().*?(?=\))' | tr ',' '\n' | tr -d ' ')
branches=$(echo "$commit_info" | sed -n 's/.*(\(.*\)).*/\1/p' | tr ',' '\n' | tr -d ' ')

echo "branches: $branches\n"

# 필요한 브랜치 정보 추출
develop_branch=$(echo "$branches" | grep -o 'develop' | head -n 1)
feature_branch=$(echo "$branches" | grep -o 'ISSUE[^ ]*' | head -n 1)

#현재 커밋 번호
current_commit=$(git rev-parse HEAD)
echo "current_commit $current_commit"

# 결과 출력
echo "Develop Branch: $develop_branch"
echo "Feature Branch: $feature_branch"


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

# HTTP 요청 URL

requestQuery(){
    issue_num=$(echo $feature_branch | grep -o '[0-9]\+')
    echo "issue_num $issue_num"
    

    url_query="https://api.notion.com/v1/databases/$database_id/query"

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
    res=$(curl -X POST "${header_args[@]}" -d "$data" "$url_query")
    echo $res
}

response=$(requestQuery)
echo "response $response"

# JSON 응답에서 Page ID 추출
_page_id=$(echo "$response" | grep -o '"object":"page","id":"[^"]*' | sed 's/.*"id":"\([^"]*\)".*/\1/')
_page_id=$(echo '{print "'$response'"}' | grep -o '"object":"page","id":"[^"]*' | sed 's/.*"id":"\([^"]*\)".*/\1/')
page_id=$(echo '{print "'$_page_id'"}'| sed 's/.*"id":"\([^"]*\)".*/\1/' | sed 's/-//g')

echo "page_id $page_id"

requestWrite(){
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

    res=$(curl -X PATCH "${header_args[@]}" -d "$body" "$url")
    echo $res
}

requestComment(){
    url="https://api.notion.com/v1/comments"
    echo "url $url"

    body='{
        "parent": {
            "page_id": "'$page_id'"
        },
        "rich_text": [
            {
                "text": {
                    "content": "[bot] 개발자 : '$author'\n"
                }
                
            },
            {
                "text": {
                    "content": "commit : '$current_commit'",
                    "link" : {
                        "url": "https://github.com/jongho-chargev/SampleFlutter/commit/'$current_commit'"
                    }
                }
            }
        ]
    }'
    echo "body $body\n"

    res=$(curl -X POST "${header_args[@]}" -d "$body" "$url")
    echo $res

}
# ...do something interesting...
if [ "$IS_USE_COMMENT" = true ] ; then
    echo $(requestComment)
else
    echo $(requestWrite)
fi


requestStatus(){
    url="https://api.notion.com/v1/pages/$page_id"

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
    
    echo "url $url"
    res=$(curl -X PATCH "${header_args[@]}" -d "$body" "$url")
    echo $res
}

echo $(requestStatus)


echo "finish"