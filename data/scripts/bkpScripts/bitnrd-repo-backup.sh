#!/bin/bash

rsync -arvz /swarm/config/bitnrd/ /swarm/github-repos/bitnrd/config/
rsync -arvz /swarm/data/bitnrd/ /swarm/github-repos/bitnrd/data/

## check difference between folders
diff=$(rsync --dry-run -arvz -e /swarm/config/bitnrd/ /swarm/github-repos/bitnrd/config/)
diff=$(rsync --dry-run -arvz -e /swarm/data/bitnrd/ /swarm/github-repos/bitnrd/data/)
line=$(echo -e "\n")
message="rsync backup to bitnrd repo is done!"
result="$message"

## format to parse to curl
echo Sending message: $result
msg_content=\"$result\"

## discord webhook
url='https://discordapp.com/api/webhooks/1318572325590798386/eL78nqy0O8h2CZQ0oKh8tnM00CqROXr1-2jpkHmrQeoQVwQQQP3KaSGpSgIAdspJeMRb'
curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
