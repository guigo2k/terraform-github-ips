#!/bin/sh

eval "$(jq -r '@sh "url=\(.url)"')"

github_ips=$(curl --silent "$url")

get_ips() {
  local key="$1"
  for ip in $(echo "$github_ips" |  jq -r ".$key | .[]"); do
    echo -n "$ip,"
  done | sed 's/.$//'
}

hooks=$(get_ips hooks)
web=$(get_ips web)
api=$(get_ips api)
git=$(get_ips git)
pages=$(get_ips pages)
importer=$(get_ips importer)

cat <<EOF
{
  "hooks": "$hooks",
  "web": "$web",
  "api": "$api",
  "git": "$git",
  "pages": "$pages",
  "importer": "$importer"
}
EOF
