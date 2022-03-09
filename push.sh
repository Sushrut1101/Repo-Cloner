#!/bin/bash

if [[ "${COMMIT_LOOPS}" != "None" && ! -z "$COMMIT_LOOPS" ]]; then
    for i in $COMMIT_LOOPS
    do
        git push -u origin HEAD~${i}:refs/heads/${TARGET_BRANCH}
    done
fi

git push -u origin $TARGET_BRANCH
