#!/bin/bash
set -e

ANSIBLE_KEY=$1
BOOTSTRAP_USER=$2
PUB_KEY_FILE_PATH=$3
INVENTORY=$4

echo "Setting remote user..."

if [ "$BOOTSTRAP_USER" == "" ]; then
    echo "You didn't provide a remote user, specify a username that has access to the remote host. Required for Ansible flag: -u"
    exit 1
fi

if [ "$PUB_KEY_FILE_PATH" == "" ]; then
    echo "Pass the absolute path to id_rsa.pub"
    exit 1
fi

if [ "$ANSIBLE_KEY" == "" ]; then
    echo "Pass the absolute path to id_rsa"
    exit 1

else
    echo -e "Bootstrapping using: \nremote_user = $BOOTSTRAP_USER\npublic key = $PUB_KEY_FILE_PATH"
    sleep 3
    echo ""
    ansible-playbook bootstrap.playbook.yml --key-file="$ANSIBLE_KEY" -u "$BOOTSTRAP_USER" --extra-vars="pub_ssh_key_file=$PUB_KEY_FILE_PATH" --inventory=$INVENTORY
fi
