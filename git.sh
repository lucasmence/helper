#!/bin/bash
FILENAME="userdata.json"
if [ $(jq -r '.git' $FILENAME) = "true" ]; then
    PATH_PREFIX="https://"
    GLOBAL_NAME=$(jq -r '.gitname' $FILENAME)
    GLOBAL_EMAIL=$(jq -r '.gitemail' $FILENAME)
    git config --global user.name "$GLOBAL_NAME"
    git config --global user.email "$GLOBAL_EMAIL"

    dataIndex=0
    jq -c '.gitdata[]' $FILENAME | while read data; do
        FOLDER=$(eval echo $(echo $data | jq -r '.folder'))
        if [ ! -d $FOLDER ]; then
            mkdir -p $FOLDER
        fi

        USERNAME=$(echo $data | jq -r '.username')
        TOKEN=$(echo $data | jq -r '.token')

        jq -c ".gitdata[$dataIndex].repositories[]" $FILENAME | while read repo; do
            REPONAME=$(echo $(echo "$repo" | sed "s/https:\/\///") | tr -d '"')
            git -C $FOLDER clone "$PATH_PREFIX$USERNAME:$TOKEN@$REPONAME"
        done

        dataIndex=$((dataIndex+1))
    done
fi
