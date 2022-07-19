#!/bin/sh

set -e

parameter=$*

curl_sh(){
  sh -c "curl -sL $C_GITHUB_URL$1 | sh -s -- $parameter"
}

if [ "$SSH_PRIVATE_KEY" ]; then
  curl_sh /linux/raw/master/script/init-ssh/init-ssh-pre.sh
  curl_sh /linux/raw/master/script/init-ssh/init-ssh.sh
fi

curl_sh /linux/raw/master/script/deploy/deploy.sh

if [ -n "$COMMAND" ]
then
  sh -c "${COMMAND}" || true
fi



if [ "$SSH_PRIVATE_KEY" ]; then
  curl_sh /linux/raw/master/script/init-ssh/init-ssh-clean.sh
fi
