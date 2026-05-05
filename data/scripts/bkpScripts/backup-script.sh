#!/bin/bash

rsync -arvz -e 'ssh -p 1234' /swarm/ admin@192.168.2.8:/share/files/bkp/swarm-bkp/

## check difference between folders
# diff <(ssh -p 1234 admin@10.10.10.210 ls -R /share/files/bkp/swarm-bkp) <(ls -R /swarm)
diff=$(rsync --dry-run -arvz -e 'ssh -p 1234' /swarm/ admin@192.168.2.8:/share/files/bkp/swarm-bkp/)
line=$(echo -e "\n")
message="rsync backup from pxsw01 to nas01 is done!"
#result="$message$line$diff"
result="$message"

## format to parse to curl
echo Sending message: $result
msg_content=\"$result\"

## discord webhook
url='https://discordapp.com/api/webhooks/1318572325590798386/eL78nqy0O8h2CZQ0oKh8tnM00CqROXr1-2jpkHmrQeoQVwQQQP3KaSGpSgIAdspJeMRb'
curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
