#!/bin/sh

set -e

parameter=$*

curl_sh(){
  sh -c "curl -sL https://github.com/cc332030$1 | sh -s -- $parameter"
}

sh -c "$1"

if [ "$SSH_PRIVATE_KEY" ]; then
  curl_sh /linux/raw/master/script/init-ssh/init-ssh-pre.sh
  curl_sh /linux/raw/master/script/init-ssh/init-ssh.sh
fi

curl_sh /linux/raw/master/script/deploy/deploy.sh
