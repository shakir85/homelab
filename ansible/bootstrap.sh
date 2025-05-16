#!/bin/bash
set -e

#USER=$1
#PUB_KEY_FILE_PATH=$2

echo "Setting remote_user..."

if [ "$USER" == "" ]; then
    echo "You didn't provide a remote_user, specify a username that exists on the remote host"
    exit 1
fi

if [ "$PUB_KEY_FILE_PATH" == "" ]; then
    echo "Pass the absolute path to id_rsa.pub"
    exit 1
else
    echo -e "Bootstrapping using: \nremote_user = $USER\npublic key = $PUB_KEY_FILE_PATH"
    sleep 3
    echo ""
    ansible-playbook bootstrap.playbook.yml --key-file="$ans" -u "$USER" --extra-vars="pub_ssh_key_file=$PUB_KEY_FILE_PATH"
fi
